#!/usr/bin/env bash
#
# Thisura skill installer
#
# Usage:
#   # Latest (tip of main) — re-run any time to update:
#   curl -fsSL https://raw.githubusercontent.com/RaZanjana/thisura-skills/main/install.sh | bash
#
#   # Pin to a specific release (any branch or git tag):
#   curl -fsSL https://raw.githubusercontent.com/RaZanjana/thisura-skills/main/install.sh | THISURA_REF=wireframe-v1.0.0 bash
#
set -euo pipefail

REPO="RaZanjana/thisura-skills"
# Branch or tag to install. Override with THISURA_REF, e.g. THISURA_REF=style-guide-v1.0.0
REF="${THISURA_REF:-main}"
SKILLS=("thisura-style-guide" "thisura-wireframe")
DEST="$HOME/.claude/skills"

echo "→ Installing Thisura skills (ref: $REF) into $DEST"

# Make sure the global skills folder exists
mkdir -p "$DEST"

# Download the repo tarball (no git required) into a temp dir
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

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

for SKILL in "${SKILLS[@]}"; do
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
