#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 3 ]]; then
  echo "Usage: $0 /path/to/repo branch-name ../repo-branch-name" >&2
  exit 2
fi

REPO="$1"
BRANCH="$2"
WORKTREE_PATH="$3"

if [[ ! -d "$REPO/.git" && ! -f "$REPO/.git" ]]; then
  echo "Not a git repo: $REPO" >&2
  exit 1
fi

if git -C "$REPO" show-ref --verify --quiet "refs/heads/$BRANCH"; then
  echo "Branch already exists: $BRANCH" >&2
  echo "Use a unique branch name, for example: $BRANCH-$(date +%Y%m%d-%H%M%S)" >&2
  exit 1
fi

git -C "$REPO" fetch --all --prune || echo "Fetch failed or offline; continuing."
git -C "$REPO" worktree add -b "$BRANCH" "$WORKTREE_PATH"

echo
echo "Created isolated worktree:"
echo "  cd $WORKTREE_PATH"
echo
echo "Run Codex from the worktree, not the main repo, to isolate edits."
