#!/usr/bin/env bash
set -euo pipefail

HANDOFF_PATH="${1:-${CODEX_HANDOFF_PATH:-$PWD/CODEX_SESSION_HANDOFF.md}}"
CODEX_HOME_DIR="${CODEX_HOME:-$HOME/.codex}"
HOOK_DIR="$CODEX_HOME_DIR/hooks"
AGENTS_PATH="$CODEX_HOME_DIR/AGENTS.md"
HOOKS_PATH="$CODEX_HOME_DIR/hooks.json"

mkdir -p "$HOOK_DIR" "$(dirname "$HANDOFF_PATH")"

if [[ ! -f "$HANDOFF_PATH" ]]; then
  cat > "$HANDOFF_PATH" <<EOF_HANDOFF
# Codex Session Handoff

Last updated: $(date '+%A, %B %d, %Y %H:%M:%S %Z')

## Current State

- New handoff file created automatically.
- Update this file with repo state, tests run, blockers, pushed commits, and next recommended command.

## Fresh Session Start

1. Read this file first.
2. Verify git status for active repos.
3. Continue from the next recommended action.

## Session Touch Log

- Created by session handoff hook from: $(pwd)
EOF_HANDOFF
fi

cat > "$HOOK_DIR/session_handoff.sh" <<'EOF_HOOK'
#!/usr/bin/env bash
set -euo pipefail

HANDOFF_PATH="${CODEX_HANDOFF_PATH:-$HOME/CODEX_SESSION_HANDOFF.md}"
EVENT="${1:-touch}"
NOW="$(date '+%A, %B %d, %Y %H:%M:%S %Z')"

mkdir -p "$(dirname "$HANDOFF_PATH")"

if [[ ! -f "$HANDOFF_PATH" ]]; then
  cat > "$HANDOFF_PATH" <<EOF_NEW
# Codex Session Handoff

Last updated: $NOW

## Current State

- New handoff file created automatically.
- Update this file with repo state, tests run, blockers, pushed commits, and next recommended command.

## Fresh Session Start

1. Read this file first.
2. Verify git status for active repos.
3. Continue from the next recommended action.

## Session Touch Log

EOF_NEW
fi

case "$EVENT" in
  start)
    {
      echo
      echo "- Session started: $NOW"
      echo "  - cwd: $(pwd)"
    } >> "$HANDOFF_PATH"
    ;;
  stop)
    {
      echo
      echo "- Session stopped: $NOW"
      echo "  - cwd: $(pwd)"
      echo "  - Reminder: update Current State, Verification, and Next Action before relying on this handoff."
    } >> "$HANDOFF_PATH"
    ;;
  *)
    {
      echo
      echo "- Session handoff touched: $NOW"
      echo "  - cwd: $(pwd)"
    } >> "$HANDOFF_PATH"
    ;;
esac
EOF_HOOK

chmod +x "$HOOK_DIR/session_handoff.sh"

if [[ -f "$HOOKS_PATH" ]]; then
  cp "$HOOKS_PATH" "$HOOKS_PATH.bak.$(date +%Y%m%d%H%M%S)"
fi

cat > "$HOOKS_PATH" <<EOF_HOOKS
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup|resume|clear|compact",
        "hooks": [
          {
            "type": "command",
            "command": "$HOOK_DIR/session_handoff.sh start",
            "timeout": 10,
            "statusMessage": "Touching session handoff"
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$HOOK_DIR/session_handoff.sh stop",
            "timeout": 10,
            "statusMessage": "Touching session handoff"
          }
        ]
      }
    ]
  }
}
EOF_HOOKS

if [[ ! -f "$AGENTS_PATH" ]]; then
  cat > "$AGENTS_PATH" <<EOF_AGENTS
# Global Codex Instructions

## Session Handoff

- At the start of any substantial session, read \`$HANDOFF_PATH\` if it exists.
- Keep the handoff updated after meaningful state changes: repos touched, commits pushed, tests run, blockers, current plan, and next recommended command.
- Before ending a substantial session, update the handoff with the latest state and verification.
- For real challenge or production code, work in small targeted diffs: inspect, choose one slice, patch narrowly, test, summarize, then iterate.
EOF_AGENTS
elif ! grep -q "## Session Handoff" "$AGENTS_PATH"; then
  cat >> "$AGENTS_PATH" <<EOF_AGENTS

## Session Handoff

- At the start of any substantial session, read \`$HANDOFF_PATH\` if it exists.
- Keep the handoff updated after meaningful state changes: repos touched, commits pushed, tests run, blockers, current plan, and next recommended command.
- Before ending a substantial session, update the handoff with the latest state and verification.
- For real challenge or production code, work in small targeted diffs: inspect, choose one slice, patch narrowly, test, summarize, then iterate.
EOF_AGENTS
fi

echo "Installed session handoff instructions and hooks."
echo "Handoff: $HANDOFF_PATH"
echo "Global AGENTS: $AGENTS_PATH"
echo "Hooks: $HOOKS_PATH"
echo
echo "In a new Codex session, run /hooks if Codex asks you to trust the new hooks."
