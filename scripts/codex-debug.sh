#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROMPT="$ROOT/prompts/05_debug.md"
REQUEST="${*:-Debug the current failure.}"

if ! command -v codex >/dev/null 2>&1; then
  echo "Codex CLI not found. Install Codex, then rerun this script." >&2
  exit 1
fi

codex "$(cat "$PROMPT")

User request:
$REQUEST"
