#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${1:-.}"

if [[ ! -d "$TARGET" ]]; then
  echo "Usage: $0 /path/to/repo-or-folder" >&2
  exit 2
fi

if git -C "$TARGET" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  repo_root="$(git -C "$TARGET" rev-parse --show-toplevel)"
  protected_regex='(^|/)(\.codex-kit|\.codex-working|\.codex-private|\.private|private-notes)(/|$)'
  tracked="$(git -C "$repo_root" ls-files .codex-kit .codex-working .codex-private .private private-notes 2>/dev/null || true)"
  staged="$(git -C "$repo_root" diff --cached --name-only | grep -E "$protected_regex" || true)"

  if [[ "$repo_root" != "$ROOT" ]]; then
    event_docs="$(git -C "$repo_root" ls-files EVENT_DAY_BUNDLE.md EVENT_DAY_CARD.md 2>/dev/null || true)"
    staged_event_docs="$(git -C "$repo_root" diff --cached --name-only | grep -E '(^|/)EVENT_DAY_(BUNDLE|CARD)\.md$' || true)"
    if [[ -n "$event_docs" ]]; then
      tracked="$(printf '%s\n%s\n' "$tracked" "$event_docs" | sed '/^$/d')"
    fi
    if [[ -n "$staged_event_docs" ]]; then
      staged="$(printf '%s\n%s\n' "$staged" "$staged_event_docs" | sed '/^$/d')"
    fi
  fi

  if [[ -n "$tracked" ]]; then
    echo "Protected local-only paths are tracked:" >&2
    printf '%s\n' "$tracked" >&2
    exit 1
  fi

  if [[ -n "$staged" ]]; then
    echo "Protected local-only paths are staged:" >&2
    printf '%s\n' "$staged" >&2
    exit 1
  fi
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
