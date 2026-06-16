#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROMPT="$ROOT/prompts/12_adversarial_review_board.md"
TARGET="${1:-.}"

if [[ ! -d "$TARGET" ]]; then
  echo "Usage: $0 /path/to/repo-or-folder" >&2
  exit 2
fi

if ! command -v codex >/dev/null 2>&1; then
  echo "Codex CLI not found. Install Codex, then rerun this script." >&2
  exit 1
fi

cd "$TARGET"
codex "$(cat "$PROMPT")

Agent team board:
$ROOT/agent_team_board.md

Target:
$TARGET"
