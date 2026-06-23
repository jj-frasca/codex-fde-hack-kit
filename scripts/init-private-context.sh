#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-.}"
if git -C "$TARGET" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  REPO_ROOT="$(git -C "$TARGET" rev-parse --show-toplevel)"
  GIT_DIR="$(git -C "$TARGET" rev-parse --git-dir)"
  case "$GIT_DIR" in
    /*) EXCLUDE_FILE="$GIT_DIR/info/exclude" ;;
    *) EXCLUDE_FILE="$REPO_ROOT/$GIT_DIR/info/exclude" ;;
  esac
else
  REPO_ROOT="$TARGET"
  EXCLUDE_FILE=""
fi

PRIVATE_DIR="$REPO_ROOT/.codex-private"
PRIVATE_FILE="$PRIVATE_DIR/hackathon_context.md"

mkdir -p "$PRIVATE_DIR"
chmod 700 "$PRIVATE_DIR" 2>/dev/null || true

if [[ ! -f "$PRIVATE_FILE" ]]; then
  cat >"$PRIVATE_FILE" <<'EOF'
# Private Hackathon Context

PRIVATE_CONTEXT_DO_NOT_COMMIT

Paste or summarize NDA-covered event context here only if the event rules allow it on this machine.

Use this file to guide:

- problem-owner questions
- artifact selection
- trust/guardrail choices
- validation strategy
- demo framing

Do not copy this content into repo files, commits, logs, public docs, or demo artifacts.
EOF
  chmod 600 "$PRIVATE_FILE" 2>/dev/null || true
  echo "Created $PRIVATE_FILE"
else
  echo "Private context file already exists: $PRIVATE_FILE"
fi

if [[ -n "$EXCLUDE_FILE" ]]; then
  mkdir -p "$(dirname "$EXCLUDE_FILE")"
  touch "$EXCLUDE_FILE"
  for pattern in ".codex-private/" ".private/" "private-notes/"; do
    if ! grep -qxF "$pattern" "$EXCLUDE_FILE"; then
      printf '%s\n' "$pattern" >>"$EXCLUDE_FILE"
    fi
  done
  echo "Protected private paths in local git exclude: $EXCLUDE_FILE"
else
  echo "Warning: target is not a git repo; no local git exclude was updated." >&2
fi

echo
echo "Use with Codex:"
echo "  Read $PRIVATE_FILE as private context. Do not copy its contents into repo files, commits, logs, demo artifacts, or public outputs."
