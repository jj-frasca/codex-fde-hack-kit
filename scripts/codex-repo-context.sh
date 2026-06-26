#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${1:-.}"

if [[ ! -d "$TARGET" ]]; then
  echo "Usage: $0 /path/to/challenge-or-target-repo" >&2
  exit 2
fi

cd "$TARGET"

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  "$ROOT/scripts/protect-challenge-repo.sh" . >/dev/null
  git_dir="$(git rev-parse --git-dir)"
  case "$git_dir" in
    /*) exclude_file="$git_dir/info/exclude" ;;
    *) exclude_file="$(git rev-parse --show-toplevel)/$git_dir/info/exclude" ;;
  esac
  mkdir -p "$(dirname "$exclude_file")"
  touch "$exclude_file"
  if ! grep -qxF ".codex-working/" "$exclude_file"; then
    printf '%s\n' ".codex-working/" >>"$exclude_file"
  fi
fi

mkdir -p .codex-working
context_file=".codex-working/REPO_CONTEXT.md"
inventory_file=".codex-working/repo_inventory.txt"

"$ROOT/.agents/skills/repo-deep-dive/scripts/repo_inventory.sh" . >"$inventory_file"

generated_at="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

{
  printf '%s\n' "# Repo Context"
  printf '\n'
  printf '%s\n' "Generated: $generated_at"
  printf '%s\n' "Target repo: current repository"
  cat <<'EOF'

This is local working context for Codex sessions and specialist agents. Do not commit `.codex-working/`.

## How To Use

1. Read this file before planning or editing.
2. Verify any stale or uncertain entry against the repo before relying on it.
3. Keep it current after meaningful architecture, command, or demo-path discoveries.
4. Before implementation, get explicit human approval for target user, artifact, app surface, persistence, trust model, human-in-loop boundary, non-goals, and demo acceptance.

## Repo Summary

TODO: Summarize what this repo appears to do in 3-6 bullets.

## App Surfaces

TODO: Identify routes, CLIs, services, workers, dashboards, or scripts where a feature could fit.

## Commands

TODO: List install, run, test, lint, format, migration, and smoke commands.

## Data Model And Persistence

TODO: Identify DBs, migration tools, models, schemas, fixtures, and persistence rules.

## Auth / Permissions

TODO: Identify auth, role checks, ownership, and approval patterns.

## Jobs / Workflows / Integrations

TODO: Identify queues, cron, webhooks, sync jobs, third-party integrations, and event patterns.

## UI Patterns

TODO: Identify UI framework, components, table/board/detail/review patterns, and style conventions.

## Testing And Verification

TODO: Identify existing test types, useful focused checks, and demo smoke path.

## Existing Domain Objects

TODO: Identify objects related to the problem owner workflow.

## Safe Extension Points

TODO: Identify where the smallest useful artifact should integrate without fighting the architecture.

## Files To Avoid

TODO: Identify generated files, vendor files, risky shared modules, credentials, and unrelated areas.

## Problem-Owner Fit

TODO: Connect repo surfaces to owner workflow, pain, trusted inputs, desired output, and risk if wrong.

## Open Human Decisions

- Target user:
- Decision/action:
- Artifact type:
- Existing app surface or extension point:
- Persistence plan:
- Trust model:
- Human-in-loop boundary:
- Non-goals:
- Demo acceptance:

## Recommended First Slice

TODO: Name the smallest useful slice only after owner discovery and repo inspection.

## Deterministic Inventory

```text
EOF
  cat "$inventory_file"
  printf '%s\n' '```'
} >"$context_file"

echo "Wrote $context_file"
echo "Wrote $inventory_file"
echo
echo "Optional refinement prompt:"
echo "  Read $context_file and refine the TODO sections from repo evidence. Keep changes inside .codex-working/REPO_CONTEXT.md."
