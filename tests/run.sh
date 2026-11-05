#!/usr/bin/env bash
# Regression tests for the lint. Run: bash tests/run.sh
set -u
cd "$(dirname "$0")/.." || exit 2
lint="skills/product-context/scripts/check-context.sh"
fail=0
expect() { # <file> <domains> <expected-exit> <grep-pattern>... (prefix a pattern with ! to require absence)
  local f="$1" d="$2" want="$3"; shift 3
  local out; out=$(bash "$lint" "$f" "$d" 2>&1); local got=$?
  [ "$got" = "$want" ] || { echo "FAIL $f: exit $got, want $want"; echo "$out"; fail=1; }
  for p in "$@"; do
    if [ "${p#!}" != "$p" ]; then echo "$out" | grep -qE -- "${p#!}" && { echo "FAIL $f: unexpected /${p#!}/"; fail=1; }
    else echo "$out" | grep -qE -- "$p" || { echo "FAIL $f: missing /$p/"; fail=1; }; fi
  done
}
expect tests/fixtures/leaky_context.md brewly.example 1 \
  'line 13: .*zd_live_' 'line 14: - License key' 'possible secret' 'admin\.internal' 'line 17: - DB host' \
  'jenny\.park@gmail\.example' 'personal email' 'unfilled \{\{placeholders' 'no "Status' 'no YYYY-MM-DD' \
  '!help@brewly' '!UNVERIFIED line'
expect tests/fixtures/clean_context.md clean.io 0 \
  '1 UNVERIFIED line' '!possible secret' '!logo@2x' '!jane@example' '!billing@eu' '!no YYYY-MM-DD' '0 error'
expect examples/acme-forms_context.md acmeforms.example 0 '0 error'
[ -f examples/brewly-one_context.md ] && expect examples/brewly-one_context.md brewly.example 0 '0 error'
expect /dev/null "" 2
[ "$fail" = 0 ] && echo "all lint tests passed"
exit "$fail"
