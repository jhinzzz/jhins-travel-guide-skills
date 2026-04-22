#!/usr/bin/env bash
# check-links.sh — validate cross-file links and section anchors in skill packages.
#
# Scans every skill under skills/*/ and checks:
#   (1) Every markdown link [text](path.md) resolves to an existing file
#   (2) Every "§AnchorName" reference matches a heading in the target file
#   (3) Every .md file under references/ is reachable from SKILL.md
#
# Exit code:
#   0 — all checks pass (warnings allowed)
#   1 — at least one error (details printed to stderr)
#
# Usage:
#   ./scripts/check-links.sh              # scan all skills
#   ./scripts/check-links.sh <skill-dir>  # scan one skill

set -uo pipefail
IFS=$'\n\t'

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

# Error/warning counts are written to temp files so subshells can accumulate.
ERR_FILE=$(mktemp)
WARN_FILE=$(mktemp)
trap 'rm -f "$ERR_FILE" "$WARN_FILE"' EXIT

red()    { printf '\033[0;31m%s\033[0m' "$1"; }
yellow() { printf '\033[0;33m%s\033[0m' "$1"; }
green()  { printf '\033[0;32m%s\033[0m' "$1"; }

die()  { printf '%s %s\n' "$(red 'ERROR:')"  "$1" >&2; echo 1 >> "$ERR_FILE"; }
warn() { printf '%s %s\n' "$(yellow 'WARN:')" "$1" >&2; echo 1 >> "$WARN_FILE"; }

# Parse an anchor token from a `(file.md) §Anchor` pattern. Stop at:
#   - end of string
#   - whitespace followed by a lowercase word (natural sentence continuation)
#   - punctuation other than dot / hyphen / digit / uppercase letter / space-uppercase
# Accepted anchors:
#   §10  §§1-10  §Intake  §Rental Car / Self-Drive  §Per-Person Price Tiers
# Not accepted (intentional — these are sentence continuations):
#   §5 for how they combine…    → anchor = "5"
#   §2 before appearing…        → anchor = "2"
#   §Intake self-drive triad    → anchor = "Intake" (rest of words are lowercase)
#
# Rule: after the initial §, greedy-consume:
#   - digits and "-" (range form)
#   - OR: one or more Title-Case words separated by space/"/"/"-"
# Stop at the first lowercase-word boundary OR punctuation we don't accept.
parse_anchor() {
  local text="$1"
  # Strip leading §.
  text="${text#§}"
  text="${text#§}"  # in case of §§

  # Numeric range: §§1-10 style.
  if [[ "$text" =~ ^([0-9]+(-[0-9]+)?) ]]; then
    echo "${BASH_REMATCH[1]}"
    return
  fi

  # Title-Case phrase: match words that start uppercase or digit, separated by
  # space, "-", or "/". Stop before the first space-then-lowercase sequence.
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
      # Inside a word — continue consuming.
      out+="$c"
    elif [ "$c" = " " ] || [ "$c" = "-" ] || [ "$c" = "/" ]; then
      # Separator. Peek ahead: if next char is uppercase/digit, keep going.
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
  # Trim trailing separators.
  echo "$out" | sed -E 's/[[:space:]/-]+$//'
}

# Normalize heading text to a comparable form.
normalize_heading() {
  sed -E 's/^#+[[:space:]]+//; s/[[:space:]]+$//'
}

# Check a single (target_file, anchor) pair against the target file's headings.
# Returns 0 if match found, 1 if not.
anchor_matches() {
  local target_path="$1"
  local anchor="$2"
  [ -f "$target_path" ] || return 1

  local headings
  headings=$(grep -E '^#+[[:space:]]' "$target_path" | normalize_heading)

  # Range form (e.g. "1-10") always accepted if the file has numbered sections.
  if [[ "$anchor" =~ ^[0-9]+-[0-9]+$ ]]; then
    echo "$headings" | grep -qE '^[0-9]+\.' && return 0
    return 1
  fi

  # Pure numeric form: find "N. Something" heading.
  if [[ "$anchor" =~ ^[0-9]+$ ]]; then
    echo "$headings" | grep -qE "^${anchor}\." && return 0
    return 1
  fi

  # Name form: case-insensitive prefix-or-contains match as a word boundary.
  local anc_lc
  anc_lc=$(echo "$anchor" | tr '[:upper:]' '[:lower:]')
  local escaped
  escaped=$(printf '%s' "$anc_lc" | sed 's/[][\.*^$/]/\\&/g')
  if echo "$headings" | tr '[:upper:]' '[:lower:]' | grep -qE "(^| |\.|-)${escaped}( |\.|-|\$|/)"; then
    return 0
  fi
  return 1
}

check_skill() {
  local skill_dir="$1"
  local skill_md="$skill_dir/SKILL.md"

  [ -f "$skill_md" ] || { warn "No SKILL.md in $skill_dir — skipping"; return 0; }

  printf '\n== %s ==\n' "$(basename "$skill_dir")"

  local all_md_files
  all_md_files=$(find "$skill_dir" -maxdepth 3 -name '*.md' -type f)

  # --- Check 1: every linked .md file exists ---
  for f in $all_md_files; do
    grep -oE '\[[^]]+\]\(([a-zA-Z0-9_./-]+\.md(#[a-zA-Z0-9_-]+)?)\)' "$f" 2>/dev/null \
      | sed -E 's/^\[[^]]+\]\(//; s/\)$//' \
      | while IFS= read -r target; do
          local target_file="${target%%#*}"
          local src_dir
          src_dir=$(dirname "$f")
          if ! [ -f "$src_dir/$target_file" ]; then
            die "$(basename "$f") → missing file: $target_file"
          fi
        done
  done

  # --- Check 2: every "(target.md) §Anchor" resolves to a heading ---
  for f in $all_md_files; do
    # Match only "[…](target.md) §…" pairs where § immediately follows the close paren + one space.
    # grep with line numbers, then per-match anchor parsing.
    while IFS= read -r line; do
      local lineno="${line%%:*}"
      local rest="${line#*:}"
      # Extract all pairs on this line.
      echo "$rest" | grep -oE '\([a-zA-Z0-9_./-]+\.md\)[[:space:]]+§+[A-Za-z0-9_ /\-]+' \
        | while IFS= read -r pair; do
            local target
            target=$(echo "$pair" | sed -E 's/^\(([^)]+)\).*/\1/')
            # Extract the raw anchor tail after § or §§.
            local raw_anchor
            raw_anchor=$(echo "$pair" | sed -E 's/^\([^)]+\)[[:space:]]+//')
            # parse_anchor trims sentence continuation.
            local anchor
            anchor=$(parse_anchor "$raw_anchor")
            [ -z "$anchor" ] && continue

            local src_dir
            src_dir=$(dirname "$f")
            local target_path="$src_dir/$target"
            [ -f "$target_path" ] || continue  # Missing file is Check 1's job.

            if ! anchor_matches "$target_path" "$anchor"; then
              die "$(basename "$f"):$lineno  $target §$anchor — anchor not found in target"
            fi
          done
    done < <(grep -nE '\([a-zA-Z0-9_./-]+\.md\)[[:space:]]+§+[A-Za-z0-9_ /\-]+' "$f" 2>/dev/null)
  done

  # --- Check 3: orphan reference files ---
  if [ -d "$skill_dir/references" ]; then
    for ref in "$skill_dir/references"/*.md; do
      [ -f "$ref" ] || continue
      local ref_name
      ref_name=$(basename "$ref")
      if ! grep -qE "\(([^)]*/)?${ref_name}(#|\))" "$skill_md" 2>/dev/null; then
        warn "$(basename "$skill_dir")/references/$ref_name is not linked from SKILL.md"
      fi
    done
  fi
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
warnings=$(wc -l < "$WARN_FILE" | tr -d ' ')

printf '\n==================================\n'
if [ "$errors" = "0" ] && [ "$warnings" = "0" ]; then
  printf '%s All link checks passed.\n' "$(green '✓')"
  exit 0
elif [ "$errors" = "0" ]; then
  printf '%s %s warning(s), no errors.\n' "$(yellow '!')" "$warnings"
  exit 0
else
  printf '%s %s error(s), %s warning(s).\n' "$(red '✗')" "$errors" "$warnings"
  exit 1
fi
