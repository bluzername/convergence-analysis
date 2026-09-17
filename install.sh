#!/usr/bin/env bash
# Install the /converge skill into a Claude Code config directory.
#
# Usage:
#   bash install.sh              # install into ~/.claude
#   CLAUDE_DIR=/path bash install.sh
#   bash install.sh --dry-run    # print what would happen, change nothing
set -euo pipefail

DRY_RUN=0
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    -h|--help) sed -n '2,7p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "Unknown argument: $arg" >&2; exit 2 ;;
  esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${CLAUDE_DIR:-$HOME/.claude}"
SRC="$SCRIPT_DIR/skills/converge/SKILL.md"
DEST_DIR="$CLAUDE_DIR/skills/converge"
LEGACY="$CLAUDE_DIR/commands/converge.md"

if [[ ! -f "$SRC" ]]; then
  echo "Source skill not found: $SRC" >&2
  exit 1
fi

if [[ $DRY_RUN -eq 1 ]]; then
  echo "[dry-run] mkdir -p $DEST_DIR"
  echo "[dry-run] cp $SRC $DEST_DIR/SKILL.md"
else
  mkdir -p "$DEST_DIR"
  cp "$SRC" "$DEST_DIR/SKILL.md"
  echo "Installed /converge skill to $DEST_DIR/SKILL.md"
fi

if [[ -f "$LEGACY" ]]; then
  echo "Note: a legacy copy exists at $LEGACY (pre-skill layout)."
  echo "      Remove it to avoid a duplicate /converge entry: rm \"$LEGACY\""
fi

echo "Usage: type /converge in any Claude Code session followed by your analysis question."
