#!/usr/bin/env bash
# check-all.sh — run every skill-hygiene check. Fails if any check fails.
#
# Run this before every release bump and/or via pre-commit. The individual
# checks can also be run on their own:
#   check-links.sh        — cross-file links + section anchors
#   check-provenance.sh   — test-prompts.json rule_refs resolve
#   check-version.sh      — VERSION vs SKILL.md / plugin.json / marketplace.json
#   check-size.sh         — SKILL.md / reference .md under rule-fatigue thresholds

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

red()   { printf '\033[0;31m%s\033[0m' "$1"; }
green() { printf '\033[0;32m%s\033[0m' "$1"; }

checks=(check-links.sh check-provenance.sh check-version.sh check-size.sh)

failed=0
for c in "${checks[@]}"; do
  printf '\n════ %s ════\n' "$c"
  if ! "$SCRIPT_DIR/$c"; then
    failed=$((failed + 1))
  fi
done

printf '\n==================================\n'
if [ "$failed" -eq 0 ]; then
  printf '%s All %d checks passed.\n' "$(green '✓')" "${#checks[@]}"
  exit 0
else
  printf '%s %d of %d checks failed.\n' "$(red '✗')" "$failed" "${#checks[@]}" >&2
  exit 1
fi
