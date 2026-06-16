#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 /path/to/worktree" >&2
  exit 2
fi

WORKTREE_PATH="$1"

git -C "$WORKTREE_PATH" rev-parse --show-toplevel >/dev/null
MAIN_REPO="$(git -C "$WORKTREE_PATH" rev-parse --git-common-dir)"
MAIN_REPO="$(cd "$MAIN_REPO/.." && pwd)"

git -C "$MAIN_REPO" worktree remove "$WORKTREE_PATH"
git -C "$MAIN_REPO" worktree prune

echo "Removed worktree: $WORKTREE_PATH"
