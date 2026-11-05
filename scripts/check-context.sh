#!/usr/bin/env bash
# Lint a generated *_context.md for leftovers, leaks and missing sections.
# Usage: scripts/check-context.sh path/to/product_context.md [allowed-email-domain]
# Exit code: 0 = clean, 1 = errors found. Warnings never fail the run.
set -u

file="${1:-}"
allow_domain="${2:-}"
[ -f "$file" ] || { echo "usage: $0 <context.md> [allowed-email-domain]"; exit 2; }

errors=0
err()  { echo "ERROR: $*"; errors=$((errors + 1)); }
warn() { echo "WARN:  $*"; }

# 1. Required sections (matched loosely by keyword in an H2 heading).
for section in "Agent rules" "Troubleshooting" "Escalation" "Volatile"; do
  grep -qiE "^## .*${section}" "$file" || err "missing a '## … ${section}' section"
done

# 2. Unfilled template placeholders and leftover template comments.
if grep -nE '\{\{[^}]+\}\}' "$file"; then err "unfilled {{placeholders}} above"; fi
if grep -nE '^<!--' "$file" | head -5 | grep -q .; then warn "template <!-- comments --> left in file"; fi

# 3. Secrets. These patterns are deliberately broad, so a false positive is cheaper than a leak.
secret_re='(sk-[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16}|gh[pousr]_[A-Za-z0-9]{30,}|xox[baprs]-[A-Za-z0-9-]+|-----BEGIN [A-Z ]*PRIVATE KEY-----|https://[0-9a-f]{20,}@[^ ]*sentry\.io|(password|passwd|secret|api[_-]?key|token)[[:space:]]*[:=][[:space:]]*[^[:space:]<{]{6,})'
if grep -niE "$secret_re" "$file"; then err "possible secret(s) above"; fi

# 4. Email addresses: anything outside the allowed support domain may be customer data.
emails=$(grep -noE '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' "$file" || true)
if [ -n "$emails" ]; then
  if [ -n "$allow_domain" ]; then emails=$(echo "$emails" | grep -viE "@${allow_domain}\$" || true); fi
  [ -n "$emails" ] && { echo "$emails"; warn "email addresses above, so confirm none belong to customers"; }
fi

# 5. Size and open questions.
lines=$(wc -l < "$file" | tr -d ' ')
[ "$lines" -gt 1500 ] && warn "$lines lines; consider splitting into context/*.md with an index"
unverified=$(grep -c 'UNVERIFIED' "$file" || true)
[ "$unverified" -gt 0 ] && warn "$unverified UNVERIFIED line(s) for the owner to confirm"

# 6. Volatile section needs a date.
grep -iA3 -E '^## .*Volatile' "$file" | grep -qE '[0-9]{4}-[0-9]{2}-[0-9]{2}' \
  || warn "Volatile section has no YYYY-MM-DD 'as of' date"

echo "---"
echo "$file: $lines lines, $errors error(s)"
[ "$errors" -eq 0 ]
