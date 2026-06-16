#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${1:-.}"

if [[ ! -d "$TARGET" ]]; then
  echo "Usage: $0 /path/to/repo-or-folder" >&2
  exit 2
fi

"$ROOT/scripts/public-safety-scan.sh" "$TARGET"

if [[ -x "$TARGET/scripts/smoke-check.sh" ]]; then
  (cd "$TARGET" && ./scripts/smoke-check.sh)
fi

if [[ -f "$TARGET/pyproject.toml" ]]; then
  if command -v uv >/dev/null 2>&1; then
    (cd "$TARGET" && uv run --extra dev pytest)
  elif command -v pytest >/dev/null 2>&1; then
    (cd "$TARGET" && pytest)
  elif [[ -x "$TARGET/.venv/bin/pytest" ]]; then
    (cd "$TARGET" && .venv/bin/pytest)
  else
    echo "Python project detected, but no supported test runner found: uv, pytest, or .venv/bin/pytest" >&2
    exit 1
  fi
fi

echo
echo "Automated pre-push checks passed."
echo "Now run adversarial review:"
echo "  $ROOT/scripts/codex-agent-board-review.sh $TARGET"
