#!/usr/bin/env bash
#
# Thisura skill installer
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/RaZanjana/thisura-skills/main/install.sh | bash
#
set -euo pipefail

REPO="RaZanjana/thisura-skills"
BRANCH="main"
SKILLS=("thisura-style-guide" "thisura-wireframe")
DEST="$HOME/.claude/skills"

echo "→ Installing Thisura skills into $DEST"

# Make sure the global skills folder exists
mkdir -p "$DEST"

# Download the repo tarball (no git required) into a temp dir
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

curl -fsSL "https://github.com/$REPO/archive/refs/heads/$BRANCH.tar.gz" \
  | tar -xz -C "$TMP"

ROOT="$TMP/$(basename "$REPO")-$BRANCH"

for SKILL in "${SKILLS[@]}"; do
  SRC="$ROOT/$SKILL"
  if [ ! -d "$SRC" ]; then
    echo "✗ Could not find the '$SKILL' folder in the repo. Skipping." >&2
    continue
  fi
  # Replace any existing copy so re-running = update
  rm -rf "$DEST/$SKILL"
  cp -R "$SRC" "$DEST/$SKILL"
  echo "✓ Installed: $DEST/$SKILL"
done

echo "→ Restart Cursor, then type / in the Agent chat to see the thisura skills."