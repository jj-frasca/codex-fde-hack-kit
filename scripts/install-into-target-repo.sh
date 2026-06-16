#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 /path/to/target/repo" >&2
  exit 2
fi

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="$1"

if [[ ! -d "$TARGET" ]]; then
  echo "Target repo does not exist: $TARGET" >&2
  exit 1
fi

if [[ -f "$TARGET/AGENTS.md" ]]; then
  echo "Warning: $TARGET/AGENTS.md already exists."
  echo "Read it first and merge these instructions manually if needed:"
  echo "  $ROOT/AGENTS.md"
else
  cp "$ROOT/AGENTS.md" "$TARGET/AGENTS.md"
  echo "Copied AGENTS.md into $TARGET"
fi

mkdir -p "$TARGET/.codex"
cp "$ROOT/.codex/config.toml.example" "$TARGET/.codex/config.toml.example"

echo
echo "Next steps:"
echo "  cd $TARGET"
echo "  codex"
echo "  $ROOT/scripts/codex-analyze.sh"
