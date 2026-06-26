Build a reusable repo context file for fresh Codex sessions.

Stay read-only except for writing `.codex-working/REPO_CONTEXT.md`.

Inspect:

- AGENTS.md and repo instructions
- README and docs
- package manifests and run/test commands
- app entrypoints, routes, pages, CLI commands, jobs, and APIs
- auth and permission patterns
- data stores, migrations, models, schemas, fixtures, and sample data
- background jobs, queues, cron, webhooks, and sync patterns
- UI framework, component library, styling conventions, and design system
- logging, audit, telemetry, error handling, and tests
- existing domain concepts related to the problem owner briefing

Write `.codex-working/REPO_CONTEXT.md` with:

```md
# Repo Context

## Repo Summary

## App Surfaces

## Commands

## Data Model And Persistence

## Auth / Permissions

## Jobs / Workflows / Integrations

## UI Patterns

## Testing And Verification

## Existing Domain Objects

## Safe Extension Points

## Files To Avoid

## Problem-Owner Fit

## Open Human Decisions

## Recommended First Slice
```

Keep it factual. Use file references. Mark unknowns clearly. Do not include secrets, private notes, credentials, local absolute paths, or proprietary material unless the challenge repo itself legitimately contains that information and event rules allow it.
