#!/usr/bin/env bash
# check-provenance.sh — validate rule_refs anchors in test-prompts.json.
#
# For every skill under skills/*/:
#   1. Read test-prompts.json (if present).
#   2. For every case's rule_refs entry, parse it as "<file.md>[ §Anchor]"
#      (anchors may be comma-separated: "§3, §4").
#   3. Verify the file exists under the skill (SKILL.md at root, everything
#      else under references/) and every anchor matches a heading.
#
# Rule files are never edited. The single source of provenance is
# test-prompts.json — each case tells you which rules it exercises.
#
# Exit code:
#   0 — every rule_refs entry resolves
#   1 — at least one entry is broken (details printed to stderr)
#
# Usage:
#   ./scripts/check-provenance.sh              # scan all skills
#   ./scripts/check-provenance.sh <skill-dir>  # scan one skill

set -uo pipefail
IFS=$'\n\t'

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

ERR_FILE=$(mktemp)
trap 'rm -f "$ERR_FILE"' EXIT

red()    { printf '\033[0;31m%s\033[0m' "$1"; }
green()  { printf '\033[0;32m%s\033[0m' "$1"; }

die()  { printf '%s %s\n' "$(red 'ERROR:')" "$1" >&2; echo 1 >> "$ERR_FILE"; }

# parse_anchor / anchor_matches — mirror check-links.sh so both checks agree on
# how "§Evidence Standard" resolves to a heading. If you change one, change both.
parse_anchor() {
  local text="$1"
  text="${text#§}"
  text="${text#§}"

  if [[ "$text" =~ ^([0-9]+(-[0-9]+)?) ]]; then
    echo "${BASH_REMATCH[1]}"
    return
  fi

  local out=""
  local i=0
  local n=${#text}
  local last_was_sep=0
  while [ $i -lt $n ]; do
    local c="${text:$i:1}"
    if [[ "$c" =~ [[:upper:]0-9] ]]; then
      out+="$c"
      last_was_sep=0
    elif [[ "$c" =~ [[:lower:]] ]] && [ $last_was_sep -eq 0 ]; then
      out+="$c"
    elif [ "$c" = " " ] || [ "$c" = "-" ] || [ "$c" = "/" ]; then
      local next="${text:$((i+1)):1}"
      if [[ "$next" =~ [[:upper:]0-9] ]]; then
        out+="$c"
        last_was_sep=1
      else
        break
      fi
    else
      break
    fi
    i=$((i+1))
  done
  echo "$out" | sed -E 's/[[:space:]/-]+$//'
}

normalize_heading() {
  sed -E 's/^#+[[:space:]]+//; s/[[:space:]]+$//'
}

anchor_matches() {
  local target_path="$1"
  local anchor="$2"
  [ -f "$target_path" ] || return 1

  local headings
  headings=$(grep -E '^#+[[:space:]]' "$target_path" | normalize_heading)

  if [[ "$anchor" =~ ^[0-9]+-[0-9]+$ ]]; then
    echo "$headings" | grep -qE '^[0-9]+\.' && return 0
    return 1
  fi

  if [[ "$anchor" =~ ^[0-9]+$ ]]; then
    echo "$headings" | grep -qE "^${anchor}\." && return 0
    return 1
  fi

  local anc_lc
  anc_lc=$(echo "$anchor" | tr '[:upper:]' '[:lower:]')
  local escaped
  escaped=$(printf '%s' "$anc_lc" | sed 's/[][\.*^$/]/\\&/g')
  if echo "$headings" | tr '[:upper:]' '[:lower:]' | grep -qE "(^| |\.|-)${escaped}( |\.|-|\$|/)"; then
    return 0
  fi
  return 1
}

# Resolve a filename referenced in rule_refs to an actual path under a skill.
# SKILL.md lives at the skill root. Every other .md lives under references/.
resolve_rule_file() {
  local skill_dir="$1"
  local filename="$2"
  if [ "$filename" = "SKILL.md" ]; then
    echo "$skill_dir/SKILL.md"
  else
    echo "$skill_dir/references/$filename"
  fi
}

# Extract rule_refs strings from test-prompts.json.
# Output: "<case_id>|<ref_string>" per line.
# Prefer jq if available; fall back to grep/awk for the project's schema
# (rule_refs is always an array of strings, one per line, already indented).
extract_rule_refs() {
  local json_file="$1"
  if command -v jq >/dev/null 2>&1; then
    jq -r '.[] | .id as $id | .assertions.rule_refs // [] | .[] | "\($id)|\(.)"' "$json_file" 2>/dev/null
    return
  fi

  # Fallback for environments without jq. Assumes the project's hand-formatted
  # layout: rule_refs is always an array of string literals, one per line.
  # POSIX awk only — no gawk extensions.
  awk '
    /"id":[[:space:]]*[0-9]+/ {
      line = $0
      sub(/^.*"id":[[:space:]]*/, "", line)
      sub(/[^0-9].*$/, "", line)
      if (line != "") id = line
    }
    /"rule_refs":[[:space:]]*\[/ { in_refs = 1; next }
    in_refs && /^[[:space:]]*\]/ { in_refs = 0; next }
    in_refs {
      line = $0
      sub(/^[[:space:]]*"/, "", line)
      sub(/",?[[:space:]]*$/, "", line)
      if (line != "" && id != "") print id "|" line
    }
  ' "$json_file"
}

check_skill() {
  local skill_dir="$1"
  local json_file="$skill_dir/test-prompts.json"

  [ -f "$json_file" ] || { printf '\n== %s ==\nno test-prompts.json — skipping\n' "$(basename "$skill_dir")"; return 0; }

  printf '\n== %s ==\n' "$(basename "$skill_dir")"

  local total=0
  local broken=0

  while IFS='|' read -r case_id ref; do
    [ -z "$ref" ] && continue
    total=$((total+1))

    # Split "<file.md> §Anchor1, §Anchor2" into filename + anchor tail.
    local filename
    filename=$(printf '%s' "$ref" | awk '{print $1}')
    local anchors_tail
    anchors_tail=$(printf '%s' "$ref" | sed -E 's/^[^ ]+[[:space:]]*//')

    if [[ ! "$filename" =~ \.md$ ]]; then
      die "case $case_id: rule_ref \"$ref\" — expected filename ending in .md"
      broken=$((broken+1))
      continue
    fi

    local target_path
    target_path=$(resolve_rule_file "$skill_dir" "$filename")

    if [ ! -f "$target_path" ]; then
      die "case $case_id: \"$ref\" — target file missing: ${target_path#$ROOT/}"
      broken=$((broken+1))
      continue
    fi

    # No anchors: file-level reference, existence is enough.
    if [ -z "$anchors_tail" ]; then
      continue
    fi

    # Split by comma. parse_anchor handles each "§Foo" token and trims sentence
    # continuations; an empty result means the token wasn't a recognizable anchor.
    local anchor_part ok=1
    while IFS= read -r anchor_part; do
      anchor_part=$(printf '%s' "$anchor_part" | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//')
      [ -z "$anchor_part" ] && continue

      local anchor
      anchor=$(parse_anchor "$anchor_part")
      if [ -z "$anchor" ]; then
        die "case $case_id: \"$ref\" — could not parse anchor from \"$anchor_part\""
        ok=0
        continue
      fi

      if ! anchor_matches "$target_path" "$anchor"; then
        die "case $case_id: \"$ref\" — §$anchor not found in $filename"
        ok=0
      fi
    done < <(printf '%s\n' "$anchors_tail" | tr ',' '\n')

    [ $ok -eq 0 ] && broken=$((broken+1))
  done < <(extract_rule_refs "$json_file")

  printf '  %d rule_refs checked, %d broken\n' "$total" "$broken"
}

# --- Main ---

if [ $# -gt 0 ]; then
  check_skill "$1"
else
  for sd in "$ROOT"/skills/*/; do
    [ -d "$sd" ] || continue
    check_skill "${sd%/}"
  done
fi

errors=$(wc -l < "$ERR_FILE" | tr -d ' ')

printf '\n==================================\n'
if [ "$errors" = "0" ]; then
  printf '%s All rule_refs resolve.\n' "$(green '✓')"
  exit 0
else
  printf '%s %s broken rule_refs\n' "$(red '✗')" "$errors" >&2
  exit 1
fi
