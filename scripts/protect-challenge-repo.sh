#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-.}"

if [[ ! -d "$TARGET" ]]; then
  echo "Usage: $0 /path/to/challenge-repo" >&2
  exit 2
fi

if ! git -C "$TARGET" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Target is not a git repo: $TARGET" >&2
  exit 2
fi

REPO_ROOT="$(git -C "$TARGET" rev-parse --show-toplevel)"
GIT_DIR="$(git -C "$TARGET" rev-parse --git-dir)"
case "$GIT_DIR" in
  /*) EXCLUDE_FILE="$GIT_DIR/info/exclude" ;;
  *) EXCLUDE_FILE="$REPO_ROOT/$GIT_DIR/info/exclude" ;;
esac

mkdir -p "$(dirname "$EXCLUDE_FILE")"
touch "$EXCLUDE_FILE"

patterns=(
  ".codex-kit/"
  ".codex-private/"
  ".private/"
  "private-notes/"
  "EVENT_DAY_BUNDLE.md"
  "EVENT_DAY_CARD.md"
)

for pattern in "${patterns[@]}"; do
  if ! grep -qxF "$pattern" "$EXCLUDE_FILE"; then
    printf '%s\n' "$pattern" >>"$EXCLUDE_FILE"
  fi
done

echo "Updated local git exclude: $EXCLUDE_FILE"

tracked="$(git -C "$REPO_ROOT" ls-files .codex-kit .codex-private .private private-notes EVENT_DAY_BUNDLE.md EVENT_DAY_CARD.md 2>/dev/null || true)"
if [[ -n "$tracked" ]]; then
  echo "Warning: protected paths are already tracked:" >&2
  printf '%s\n' "$tracked" >&2
  exit 1
fi

staged="$(git -C "$REPO_ROOT" diff --cached --name-only | grep -E '(^|/)(\.codex-kit|\.codex-private|\.private|private-notes)(/|$)|(^|/)EVENT_DAY_(BUNDLE|CARD)\.md$' || true)"
if [[ -n "$staged" ]]; then
  echo "Warning: protected paths are staged:" >&2
  printf '%s\n' "$staged" >&2
  exit 1
fi

echo "Challenge repo protection check passed."
