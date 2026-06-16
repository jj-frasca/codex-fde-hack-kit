#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROMPT="$ROOT/prompts/02_problem_owner_interview.md"
REQUEST="${*:-Prepare problem-owner questions for the current challenge.}"

if ! command -v codex >/dev/null 2>&1; then
  echo "Codex CLI not found. Install Codex, then rerun this script." >&2
  exit 1
fi

codex "$(cat "$PROMPT")

User request:
$REQUEST"
