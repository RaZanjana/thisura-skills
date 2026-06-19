#!/usr/bin/env bash
#
# Thisura skill installer
#
# Usage:
#   # Latest (tip of main) — re-run any time to update. Opens an interactive picker:
#   curl -fsSL https://raw.githubusercontent.com/RaZanjana/thisura-skills/main/install.sh | bash
#
#   # Pin to a specific release (any branch or git tag):
#   curl -fsSL https://raw.githubusercontent.com/RaZanjana/thisura-skills/main/install.sh | THISURA_REF=wireframe-v1.0.0 bash
#
#   # Non-interactive selection (skip the picker), e.g. for scripts/CI:
#   curl -fsSL https://raw.githubusercontent.com/RaZanjana/thisura-skills/main/install.sh | THISURA_SKILLS=all bash
#   curl -fsSL https://raw.githubusercontent.com/RaZanjana/thisura-skills/main/install.sh | THISURA_SKILLS="thisura-wireframe" bash
#
set -euo pipefail

REPO="RaZanjana/thisura-skills"
# Branch or tag to install. Override with THISURA_REF, e.g. THISURA_REF=style-guide-v1.0.0
REF="${THISURA_REF:-main}"
DEST="$HOME/.claude/skills"

# Available skills (index-aligned with DESCRIPTIONS).
SKILLS=("thisura-style-guide" "thisura-wireframe")
DESCRIPTIONS=(
  "Figma design tokens + a bound style guide for dev hand-off"
  "Lo-fi journey wireframes in FigJam, then lo-fi screens in Figma"
)

SELECTED=()
TMP=""
CURSOR_HIDDEN=0

cleanup() {
  [ "$CURSOR_HIDDEN" = "1" ] && printf '\033[?25h' >&2 || true
  [ -n "$TMP" ] && rm -rf "$TMP" || true
}
trap cleanup EXIT

add_unique() {
  local item="$1" existing
  for existing in ${SELECTED[@]+"${SELECTED[@]}"}; do
    [ "$existing" = "$item" ] && return 0
  done
  SELECTED+=("$item")
}

# Parse a selection string ("all" or comma/space-separated skill names) into SELECTED.
parse_selection() {
  local input token s matched
  input="${1//,/ }"
  input="$(printf '%s' "$input" | tr '[:upper:]' '[:lower:]')"
  SELECTED=()
  for token in $input; do
    if [ "$token" = "all" ]; then
      SELECTED=("${SKILLS[@]}")
      return 0
    fi
    matched=""
    for s in "${SKILLS[@]}"; do
      if [ "$token" = "$s" ] || [ "thisura-$token" = "$s" ]; then
        matched="$s"
        break
      fi
    done
    if [ -n "$matched" ]; then
      add_unique "$matched"
    else
      return 1
    fi
  done
  [ "${#SELECTED[@]}" -gt 0 ]
}

# Interactive checkbox picker: ↑/↓ or j/k to move, space to toggle, a = all, enter = confirm.
# Row 0 is the "all" toggle; rows 1..N are the skills.
multiselect() {
  local nskills=${#SKILLS[@]}
  local rows=$((nskills + 1))
  local checked=()
  local i
  for ((i = 0; i < nskills; i++)); do checked[$i]=1; done   # default: everything selected
  local cursor=0

  all_checked() {
    local c
    for c in "${checked[@]}"; do [ "$c" = "1" ] || return 1; done
    return 0
  }
  set_all() {
    local v="$1" j
    for ((j = 0; j < nskills; j++)); do checked[$j]=$v; done
  }

  printf '\033[?25l' >&2   # hide cursor
  CURSOR_HIDDEN=1
  echo "" >&2
  echo "Select Thisura skills to install:" >&2
  echo "  ↑/↓ move · space toggle · a = all · enter = confirm" >&2

  local first=1 idx mark pointer label desc key rest
  while true; do
    if [ "$first" = "1" ]; then first=0; else printf '\033[%dA' "$rows" >&2; fi
    for ((idx = 0; idx < rows; idx++)); do
      if [ "$idx" = "$cursor" ]; then pointer="›"; else pointer=" "; fi
      if [ "$idx" = 0 ]; then
        if all_checked; then mark="x"; else mark=" "; fi
        label="all"
        desc="install everything below"
      else
        if [ "${checked[$((idx - 1))]}" = "1" ]; then mark="x"; else mark=" "; fi
        label="${SKILLS[$((idx - 1))]}"
        desc="${DESCRIPTIONS[$((idx - 1))]}"
      fi
      printf '\033[2K\r %s [%s] %-22s — %s\n' "$pointer" "$mark" "$label" "$desc" >&2
    done

    IFS= read -rsn1 key < /dev/tty || key=""
    case "$key" in
      $'\x1b')   # escape sequence (arrow keys)
        read -rsn2 -t 1 rest < /dev/tty || rest=""
        case "$rest" in
          *A) cursor=$(((cursor - 1 + rows) % rows)) ;;
          *B) cursor=$(((cursor + 1) % rows)) ;;
        esac
        ;;
      k | K) cursor=$(((cursor - 1 + rows) % rows)) ;;
      j | J) cursor=$(((cursor + 1) % rows)) ;;
      a | A)
        if all_checked; then set_all 0; else set_all 1; fi
        ;;
      ' ')
        if [ "$cursor" = 0 ]; then
          if all_checked; then set_all 0; else set_all 1; fi
        else
          i=$((cursor - 1))
          if [ "${checked[$i]}" = "1" ]; then checked[$i]=0; else checked[$i]=1; fi
        fi
        ;;
      '' | $'\n' | $'\r') break ;;   # enter confirms
      q | Q)
        printf '\033[?25h' >&2
        CURSOR_HIDDEN=0
        echo "" >&2
        echo "Aborted — nothing installed." >&2
        exit 1
        ;;
    esac
  done

  printf '\033[?25h' >&2   # restore cursor
  CURSOR_HIDDEN=0
  echo "" >&2

  SELECTED=()
  for ((i = 0; i < nskills; i++)); do
    [ "${checked[$i]}" = "1" ] && SELECTED+=("${SKILLS[$i]}")
  done
  if [ "${#SELECTED[@]}" -eq 0 ]; then
    echo "No skills selected — nothing to do." >&2
    exit 0
  fi
}

choose_skills() {
  # 1) Explicit, non-interactive selection wins.
  if [ -n "${THISURA_SKILLS:-}" ]; then
    if ! parse_selection "$THISURA_SKILLS"; then
      echo "✗ Invalid THISURA_SKILLS value: '$THISURA_SKILLS'." >&2
      exit 1
    fi
    return
  fi
  # 2) No terminal to prompt on (e.g. piped in CI) -> install all.
  if [ ! -r /dev/tty ]; then
    SELECTED=("${SKILLS[@]}")
    return
  fi
  # 3) Interactive checkbox picker, read from the terminal (works through curl | bash).
  multiselect
}

choose_skills

echo "→ Installing into $DEST (ref: $REF): ${SELECTED[*]}"

mkdir -p "$DEST"

# Download the repo tarball (no git required) into a temp dir
TMP="$(mktemp -d)"

if ! curl -fsSL "https://github.com/$REPO/archive/refs/tags/$REF.tar.gz" 2>/dev/null | tar -xz -C "$TMP" 2>/dev/null; then
  # Not a tag (or download failed) — fall back to treating REF as a branch
  curl -fsSL "https://github.com/$REPO/archive/refs/heads/$REF.tar.gz" | tar -xz -C "$TMP"
fi

# The tarball extracts into a single top-level dir whose name depends on the ref;
# resolve it instead of hard-coding so tags and branches both work.
ROOT=""
for d in "$TMP"/*/; do
  ROOT="${d%/}"
  break
done
if [ -z "$ROOT" ]; then
  echo "✗ Could not unpack the repo for ref '$REF'." >&2
  exit 1
fi

for SKILL in "${SELECTED[@]}"; do
  SRC="$ROOT/$SKILL"
  if [ ! -d "$SRC" ]; then
    echo "✗ Could not find the '$SKILL' folder in the repo. Skipping." >&2
    continue
  fi
  # Replace any existing copy so re-running = update
  rm -rf "$DEST/$SKILL"
  cp -R "$SRC" "$DEST/$SKILL"
  VERSION="$(awk -F': *' '/^version:/{print $2; exit}' "$DEST/$SKILL/SKILL.md" 2>/dev/null || true)"
  echo "✓ Installed: $DEST/$SKILL${VERSION:+ (v$VERSION)}"
done

echo "→ Restart Cursor, then type / in the Agent chat to see the thisura skills."
