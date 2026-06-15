#!/usr/bin/env bash
#
# Thisura skill installer
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/RaZanjana/thisura-skills/main/install.sh | bash
#
set -euo pipefail

REPO="RaZanjana/thisura-skills"
BRANCH="main"
SKILL="thisura-style-guide"
DEST="$HOME/.claude/skills"

echo "→ Installing '$SKILL' into $DEST"

# Make sure the global skills folder exists
mkdir -p "$DEST"

# Download the repo tarball (no git required) into a temp dir
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

curl -fsSL "https://github.com/$REPO/archive/refs/heads/$BRANCH.tar.gz" \
  | tar -xz -C "$TMP"

SRC="$TMP/$(basename "$REPO")-$BRANCH/$SKILL"

if [ ! -d "$SRC" ]; then
  echo "✗ Could not find the '$SKILL' folder in the repo. Aborting." >&2
  exit 1
fi

# Replace any existing copy so re-running = update
rm -rf "$DEST/$SKILL"
cp -R "$SRC" "$DEST/$SKILL"

echo "✓ Installed: $DEST/$SKILL"
echo "→ Restart Cursor, then type /$SKILL in the Agent chat."