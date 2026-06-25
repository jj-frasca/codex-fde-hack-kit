#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${1:-}"

if [[ -z "$TARGET" || ! -d "$TARGET" ]]; then
  echo "Usage: $0 /path/to/challenge-repo" >&2
  exit 2
fi

if ! git -C "$TARGET" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Target is not a git repo: $TARGET" >&2
  exit 2
fi

REPO_ROOT="$(git -C "$TARGET" rev-parse --show-toplevel)"
DEST="$REPO_ROOT/.codex-kit/codex-fde-hack-kit"
STAMP="$(date +%Y%m%d%H%M%S)"

"$ROOT/scripts/protect-challenge-repo.sh" "$REPO_ROOT" >/dev/null

if [[ -e "$DEST" ]]; then
  BACKUP="$DEST.bak.$STAMP"
  mv "$DEST" "$BACKUP"
  echo "Backed up existing embedded kit to $BACKUP"
fi

mkdir -p "$DEST"

items=(
  "AGENTS.md"
  "AGENTS.global.md"
  "DAY_OF.md"
  "EVENT_DAY_BUNDLE.md"
  "EVENT_DAY_CARD.md"
  "README.md"
  "agent_team_board.md"
  "demo_readme_template.md"
  "hackathon_day_checklist.md"
  "hackathon_quickstart.md"
  ".agents"
  ".codex"
  "docs"
  "prompts"
  "scripts"
  "skills"
)

for item in "${items[@]}"; do
  cp -R "$ROOT/$item" "$DEST/"
done

"$DEST/scripts/protect-challenge-repo.sh" "$REPO_ROOT"

cat >"$REPO_ROOT/.codex-kit/README.md" <<'EOF'
# Local Codex Kit

This directory is local operational tooling for the hackathon. It is intentionally excluded through `.git/info/exclude`.

Run scripts from:

```bash
.codex-kit/codex-fde-hack-kit/scripts/
```

Do not commit this directory.
EOF

echo
echo "Embedded public kit at: $DEST"
echo "Run from challenge repo:"
echo "  .codex-kit/codex-fde-hack-kit/scripts/codex-deep-dive.sh ."
echo "  .codex-kit/codex-fde-hack-kit/scripts/pre-push-check.sh ."
