#!/bin/bash
# Install convergence-analysis as a global Claude Code skill
set -euo pipefail

COMMANDS_DIR="$HOME/.claude/commands"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$COMMANDS_DIR"
cp "$SCRIPT_DIR/converge.md" "$COMMANDS_DIR/converge.md"

echo "Installed /converge command to $COMMANDS_DIR/converge.md"
echo "Usage: type /converge in any Claude Code session followed by your analysis question."
