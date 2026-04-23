#!/usr/bin/env bash
# check-version.sh — all version numbers must agree with VERSION.
#
# Sources checked:
#   - VERSION                                   (canonical)
#   - skills/*/SKILL.md                          "Version: **X.Y.Z**"
#   - .claude-plugin/plugin.json                "version": "X.Y.Z"
#   - .claude-plugin/marketplace.json           every "version": "X.Y.Z"
#
# Exit 0 if all match canonical. Exit 1 if any drift, listing every mismatch.

set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

red()   { printf '\033[0;31m%s\033[0m' "$1"; }
green() { printf '\033[0;32m%s\033[0m' "$1"; }

if [ ! -f VERSION ]; then
  printf '%s VERSION file missing\n' "$(red 'ERROR:')" >&2
  exit 1
fi

CANONICAL=$(tr -d '[:space:]' < VERSION)
if [ -z "$CANONICAL" ]; then
  printf '%s VERSION is empty\n' "$(red 'ERROR:')" >&2
  exit 1
fi

mismatches=0
report() {
  printf '  %-55s %s\n' "$1" "$2"
  mismatches=$((mismatches + 1))
}

printf 'Canonical version: %s\n' "$CANONICAL"
printf '\nChecking:\n'

# SKILL.md files — match "Version: **X.Y.Z**" on any line.
for skill_md in skills/*/SKILL.md; do
  [ -f "$skill_md" ] || continue
  found=$(grep -oE 'Version:[[:space:]]*\*\*[0-9]+\.[0-9]+\.[0-9]+\*\*' "$skill_md" \
    | head -1 \
    | sed -E 's/Version:[[:space:]]*\*\*([^*]+)\*\*/\1/')
  if [ -z "$found" ]; then
    report "$skill_md" "no Version line found"
  elif [ "$found" != "$CANONICAL" ]; then
    report "$skill_md" "$found (expected $CANONICAL)"
  else
    printf '  %-55s %s\n' "$skill_md" "$(green 'OK')"
  fi
done

# plugin.json — single top-level "version": "…"
PLUGIN_JSON=".claude-plugin/plugin.json"
if [ -f "$PLUGIN_JSON" ]; then
  found=$(grep -oE '"version":[[:space:]]*"[0-9]+\.[0-9]+\.[0-9]+"' "$PLUGIN_JSON" \
    | head -1 \
    | sed -E 's/.*"([^"]+)".*/\1/')
  if [ "$found" != "$CANONICAL" ]; then
    report "$PLUGIN_JSON" "$found (expected $CANONICAL)"
  else
    printf '  %-55s %s\n' "$PLUGIN_JSON" "$(green 'OK')"
  fi
fi

# marketplace.json — may contain multiple "version": "…" entries; check all.
MARKET_JSON=".claude-plugin/marketplace.json"
if [ -f "$MARKET_JSON" ]; then
  line_no=0
  while IFS= read -r line; do
    line_no=$((line_no + 1))
    if [[ "$line" =~ \"version\":[[:space:]]*\"([0-9]+\.[0-9]+\.[0-9]+)\" ]]; then
      found="${BASH_REMATCH[1]}"
      if [ "$found" != "$CANONICAL" ]; then
        report "$MARKET_JSON:$line_no" "$found (expected $CANONICAL)"
      else
        printf '  %-55s %s\n' "$MARKET_JSON:$line_no" "$(green 'OK')"
      fi
    fi
  done < "$MARKET_JSON"
fi

printf '\n==================================\n'
if [ $mismatches -eq 0 ]; then
  printf '%s All versions match %s\n' "$(green '✓')" "$CANONICAL"
  exit 0
else
  printf '%s %d version mismatch(es)\n' "$(red '✗')" "$mismatches" >&2
  exit 1
fi
