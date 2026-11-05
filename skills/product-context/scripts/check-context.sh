#!/usr/bin/env bash
# Lint a generated *_context.md for leaks, leftovers and shape problems.
#
# Usage: bash check-context.sh <context.md> [allowed-email-domains]
#   allowed-email-domains: comma-separated, e.g. "acme.com,acmehelp.io". Subdomains are allowed too.
#
# Exit code: 0 = no errors, 1 = errors, 2 = usage. Warnings never fail the run.
# To accept a confirmed false positive, append  <!-- lint-ok -->  to that line.
set -u

file="${1:-}"
allow="${2:-}"
[ -f "$file" ] || { echo "usage: bash $0 <context.md> [allowed-email-domains]" >&2; exit 2; }
command -v perl >/dev/null 2>&1 || { echo "check-context.sh needs perl" >&2; exit 2; }

ALLOW="$allow" perl -e '
use strict; use warnings;
my ($file) = @ARGV;
open my $fh, "<", $file or die "cannot read $file\n";
my @lines = <$fh>; close $fh;
my ($errors, $warnings) = (0, 0);
sub err  { print "ERROR: $_[0]\n"; $errors++ }
sub warn_ { print "WARN:  $_[0]\n"; $warnings++ }
sub at   { my ($n, $t) = @_; $t =~ s/\s+$//; $t = substr($t, 0, 140) . "…" if length $t > 140; return "  line $n: $t\n" }

# Lines that are not checked for leaks: confirmed false positives.
my @scan = map { $lines[$_] =~ /<!--\s*lint-ok\s*-->/ ? "" : $lines[$_] } 0..$#lines;

# ---- 1. Sections -----------------------------------------------------------
my @h2; # [line_index, text]
for my $i (0..$#lines) { push @h2, [$i, $1] if $lines[$i] =~ /^##\s+(.*?)\s*$/ }
for my $need ("Agent rules", "Troubleshooting", "Escalation", "Volatile") {
  err("missing a \"## … $need\" section") unless grep { $_->[1] =~ /\Q$need\E/i } @h2;
}
warn_("no \"## Contents\" section (agents use it to jump by symptom)") unless grep { $_->[1] =~ /^Contents/i } @h2;

my ($rules) = grep { $h2[$_][1] =~ /Agent rules/i } 0..$#h2;
if (defined $rules) {
  my @before = grep { $h2[$_][1] !~ /^Contents/i } 0..$rules-1;
  warn_("\"Agent rules\" should be the first section after Contents") if @before;
  my $end = $rules < $#h2 ? $h2[$rules+1][0] : scalar @lines;
  my $len = $end - $h2[$rules][0];
  warn_("Agent rules section is $len lines; keep it at 60 or fewer") if $len > 60;
}

my %seen;
for (map { $lines[$_] } grep { $lines[$_] =~ /^#{2,4}\s/ } 0..$#lines) {
  (my $h = lc $_) =~ s/\s+$//;
  warn_("duplicate heading: $_") if $seen{$h}++ == 1;
}

# ---- 2. Template leftovers -------------------------------------------------
my @ph = grep { $lines[$_] =~ /\{\{[^}]+\}\}/ } 0..$#lines;
if (@ph) { print at($_+1, $lines[$_]) for @ph; err("unfilled {{placeholders}} above") }
my @cm = grep { $lines[$_] =~ /<!--/ && $lines[$_] !~ /<!--\s*lint-ok\s*-->/ } 0..$#lines;
warn_(scalar(@cm) . " template <!-- comment --> line(s) left in, first at line " . ($cm[0]+1)) if @cm;

# ---- 3. Secrets ------------------------------------------------------------
my @secret_res = (
  qr/\bsk-[A-Za-z0-9_-]{20,}/, qr/\b[rsp]k_(?:live|test)_[A-Za-z0-9]{10,}/,
  qr/\b[a-z]{2,12}_(?:live|prod|secret)_[A-Za-z0-9]{12,}/, qr/\bAKIA[0-9A-Z]{16}\b/,
  qr/\bgh[pousr]_[A-Za-z0-9]{30,}/, qr/\bglpat-[A-Za-z0-9_-]{20,}/, qr/\bxox[baprs]-[A-Za-z0-9-]{10,}/,
  qr/\bAIza[0-9A-Za-z_-]{35}\b/, qr/\beyJ[A-Za-z0-9_-]{10,}\.eyJ[A-Za-z0-9_-]{10,}/,
  qr/-----BEGIN [A-Z ]*PRIVATE KEY-----/, qr{https?://[0-9a-f]{20,}@[^\s]*sentry}i,
  # keyword, then "is" / ":" / "=", then a 12+ char value that mixes letters and digits
  qr/\b(?:password|passwd|secret|api[ _-]?key|access[ _-]?key|client[ _-]?secret|token|licen[cs]e[ _-]?key|auth[ _-]?key|serial[ _-]?key)\b[^\n]{0,20}?(?:\bis\b|[:=])\s*[`\x27"]?(?=[A-Za-z0-9_-]*\d)(?=[A-Za-z0-9_-]*[A-Za-z])[A-Za-z0-9_-]{12,}/i,
);
my @sec = grep { my $l = $scan[$_]; grep { $l =~ $_ } @secret_res } 0..$#scan;
if (@sec) { print at($_+1, $lines[$_]) for @sec; err("possible secret(s) above: remove them, and tell the owner to rotate any real one") }

my @host = grep { $scan[$_] =~ /\b[a-z0-9-]+\.(?:internal|intranet|corp)\.[a-z0-9.-]+|\b(?:10\.\d{1,3}|192\.168|172\.(?:1[6-9]|2\d|3[01]))\.\d{1,3}\.\d{1,3}\b/i } 0..$#scan;
if (@host) { print at($_+1, $lines[$_]) for @host; warn_("internal hostname(s) or private IP(s) above: point to where a human finds them instead") }

# ---- 4. Customer data: email addresses --------------------------------------
my @allow = grep { length } map { s/^\s+|\s+$//gr } split /,/, ($ENV{ALLOW} // "");
my $freemail = qr/\@(?:gmail|googlemail|yahoo|ymail|hotmail|outlook|live|msn|icloud|me|aol|proton|protonmail|gmx|mail|yandex|zoho|qq|163)\.[a-z.]+$/i;
# Personal-mail domains are checked first, so test fixtures can use e.g. name@gmail.example.
my $reserved = qr/\@(?:[a-z0-9-]+\.)*(?:example\.(?:com|org|net)|example|test|invalid|localhost)$/i;
my (@free, @other);
for my $i (0..$#scan) {
  while ($scan[$i] =~ /([A-Za-z0-9._%+-]+\@[A-Za-z0-9.-]+\.[A-Za-z]{2,})/g) {
    my $e = $1;
    next if $e =~ /\.(?:png|jpe?g|gif|svg|webp|avif)$/i;       # logo@2x.png
    if ($e =~ $freemail) { push @free, [$i, $e]; next }
    next if $e =~ $reserved;
    next if grep { $e =~ /\@(?:[a-z0-9-]+\.)*\Q$_\E$/i } @allow;
    push @other, [$i, $e];
  }
}
if (@free)  { print "  line " . ($_->[0]+1) . ": $_->[1]\n" for @free;  err("personal email address(es) above look like customer data") }
if (@other) { print "  line " . ($_->[0]+1) . ": $_->[1]\n" for @other;
  warn_("email address(es) above are outside " . (@allow ? join(", ", @allow) : "any allowed domain (pass yours as the 2nd argument)") . "; confirm none belong to customers") }

# ---- 5. Status, open questions, size ---------------------------------------
my @head = @lines[0 .. ($#lines < 14 ? $#lines : 14)];
my ($status) = map { /Status:\s*([^·\n]*)/i ? $1 : () } @head;
warn_("no \"Status: ready | draft\" line in the header") unless defined $status;
my $unv = grep { /UNVERIFIED/ && !/^\s*>/ } @lines;
if ($unv) {
  warn_("$unv UNVERIFIED line(s) for the owner to confirm");
  warn_("header says Status: ready, but UNVERIFIED lines remain; check none are on prices, refunds, hours or escalation")
    if defined $status && $status =~ /^\s*ready/i;
}
my $n = scalar @lines;
warn_("$n lines; consider splitting into context/*.md with an index") if $n > 1500;

# ---- 6. Volatile section needs an "as of" date -------------------------------
my ($vol) = grep { $h2[$_][1] =~ /Volatile/i } 0..$#h2;
if (defined $vol) {
  my $end = $vol < $#h2 ? $h2[$vol+1][0] : scalar @lines;
  my $body = join "", @lines[$h2[$vol][0] .. $end-1];
  warn_("Volatile section has no YYYY-MM-DD \"as of\" date") unless $body =~ /\b\d{4}-\d{2}-\d{2}\b/;
}

print "---\n$file: $n lines, $errors error(s), $warnings warning(s)\n";
exit($errors ? 1 : 0);
' "$file"
