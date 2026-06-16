#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST="$HOME/.codex/AGENTS.md"

mkdir -p "$HOME/.codex"
cp "$ROOT/AGENTS.global.md" "$DEST"

echo "Installed global Codex instructions to $DEST"
