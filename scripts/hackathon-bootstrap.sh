#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 /path/to/challenge-or-target-repo" >&2
  exit 2
fi

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="$1"

if [[ ! -d "$TARGET" ]]; then
  echo "Target repo does not exist: $TARGET" >&2
  exit 1
fi

echo "Installing global Codex working agreements..."
"$ROOT/scripts/install-global-agents.sh"

echo
echo "Installing project Codex setup into target repo..."
"$ROOT/scripts/install-into-target-repo.sh" "$TARGET"

echo
echo "Bootstrap complete."
echo
echo "Start here:"
echo "  cd $TARGET"
echo "  codex"
echo
echo "Fast loop:"
echo "  $ROOT/scripts/codex-analyze.sh"
echo "  $ROOT/scripts/codex-interview-plan.sh \"Prepare questions for the problem owner\""
echo "  $ROOT/scripts/codex-plan.sh \"Frame the smallest useful slice\""
echo "  $ROOT/scripts/codex-implement.sh"
echo "  $ROOT/scripts/codex-review.sh"
echo "  $ROOT/scripts/codex-demo.sh"
echo
echo "Before pushing or demoing:"
echo "  $ROOT/scripts/pre-push-check.sh $TARGET"
echo "  $ROOT/scripts/codex-agent-board-review.sh $TARGET"
