#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 /path/to/challenge-or-target-repo" >&2
  exit 2
fi

TARGET="$1"

if [[ ! -d "$TARGET" ]]; then
  echo "Target repo does not exist: $TARGET" >&2
  exit 1
fi

if ! command -v codex >/dev/null 2>&1; then
  echo "Codex CLI not found. Install Codex, then rerun this script." >&2
  exit 1
fi

cd "$TARGET"
codex --profile onsite-safe --sandbox read-only "Use \$repo-deep-dive. If the skill is not discoverable yet, read ${CODEX_HOME:-$HOME/.codex}/skills/repo-deep-dive/SKILL.md and follow it. Inspect this repo deeply, explain the architecture, find flaws, and recommend the best one-day hackathon slice. Stay read-only; do not edit files."
