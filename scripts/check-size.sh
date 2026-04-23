#!/usr/bin/env bash
# check-size.sh — skill files should not balloon past the rule-fatigue threshold.
#
# Thresholds (aligned with v0.6.0 decision: SKILL.md was 331 lines, trimmed to
# 190; rule fatigue was real. These caps keep it from drifting back.)
#
#   SKILL.md                            > 250  →  ERROR
#   skills/*/references/*.md            > 220  →  WARN
#                                       > 260  →  ERROR
#
# Exit 0 on clean or warn-only; exit 1 on any error.

set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

SKILL_MAX=250
REF_WARN=220
REF_ERROR=260
# Deep reference files are opt-in and expected to be larger.
DEEP_WARN=400
DEEP_ERROR=500

red()    { printf '\033[0;31m%s\033[0m' "$1"; }
yellow() { printf '\033[0;33m%s\033[0m' "$1"; }
green()  { printf '\033[0;32m%s\033[0m' "$1"; }

errors=0
warnings=0

printf 'Thresholds:  SKILL.md > %d = ERROR · reference > %d warn / > %d error · deep > %d warn / > %d error\n\n' \
  "$SKILL_MAX" "$REF_WARN" "$REF_ERROR" "$DEEP_WARN" "$DEEP_ERROR"

check_file() {
  local path="$1"
  local limit_warn="$2"
  local limit_err="$3"
  [ -f "$path" ] || return 0
  local lines
  lines=$(wc -l < "$path" | tr -d ' ')

  if [ "$lines" -gt "$limit_err" ]; then
    printf '  %-55s %4d lines   %s\n' "$path" "$lines" "$(red 'ERROR')"
    errors=$((errors + 1))
  elif [ "$lines" -gt "$limit_warn" ]; then
    printf '  %-55s %4d lines   %s\n' "$path" "$lines" "$(yellow 'WARN')"
    warnings=$((warnings + 1))
  else
    printf '  %-55s %4d lines   %s\n' "$path" "$lines" "$(green 'OK')"
  fi
}

for sd in skills/*/; do
  [ -d "$sd" ] || continue
  skill_md="${sd}SKILL.md"
  # SKILL.md: single threshold — anything over SKILL_MAX is an error.
  check_file "$skill_md" "$SKILL_MAX" "$SKILL_MAX"

  if [ -d "${sd}references" ]; then
    for ref in "${sd}references"/*.md; do
      [ -f "$ref" ] || continue
      check_file "$ref" "$REF_WARN" "$REF_ERROR"
    done
  fi

  if [ -d "${sd}references/deep" ]; then
    for ref in "${sd}references/deep"/*.md; do
      [ -f "$ref" ] || continue
      check_file "$ref" "$DEEP_WARN" "$DEEP_ERROR"
    done
  fi
done

printf '\n==================================\n'
if [ "$errors" -eq 0 ] && [ "$warnings" -eq 0 ]; then
  printf '%s All files within budget.\n' "$(green '✓')"
  exit 0
elif [ "$errors" -eq 0 ]; then
  printf '%s %d warning(s), no errors.\n' "$(yellow '!')" "$warnings"
  exit 0
else
  printf '%s %d error(s), %d warning(s)\n' "$(red '✗')" "$errors" "$warnings" >&2
  exit 1
fi
