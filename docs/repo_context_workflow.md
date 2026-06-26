# Repo Context Workflow

Use this at the start of an unfamiliar challenge repo so every fresh Codex session can read the same map instead of rediscovering the codebase. Timebox it to 5-10 minutes unless the repo is unusually large or confusing.

## Goal

Create an ignored working file:

```text
.codex-working/REPO_CONTEXT.md
```

This file is local operational context. It must not be committed.

The default helper is deterministic: it updates local git excludes, runs repo inventory, writes the context template, and does not run Codex or modify app code.

The first generated file is a scaffold plus deterministic inventory. Before using it for architecture decisions, ask Codex to refine the TODO sections from repo evidence and keep edits inside `.codex-working/REPO_CONTEXT.md`.

## What It Should Capture

- repo purpose and primary app surfaces
- framework, package manager, and run/test commands
- routing and entrypoints
- auth and permission patterns
- data stores, migrations, and models
- background jobs, queues, cron, webhooks, or sync patterns
- UI component/design-system conventions
- logging, telemetry, audit, and error handling patterns
- existing domain objects related to the problem
- trusted input sources available for the hackathon
- likely extension points for the chosen feature
- files to avoid touching
- verification commands and demo command path
- open architecture/product questions for the human operator

## Human-Led Planning Gate

Before implementation, the human operator should explicitly decide:

- target user and decision/action
- artifact type
- app surface: existing page, new route, CLI/script, report, job, workflow, or tracker
- persistence plan: existing DB/model/migration, existing file pattern, or no persistence
- trust model: source evidence, audit trail, confidence, review queue, or dry run
- human-in-loop boundary
- non-goals
- demo acceptance

Codex should challenge gaps, but the human should own these choices.

## Prompt

```text
Read .codex-working/REPO_CONTEXT.md and the current problem-owner notes. Before implementation, ask me to confirm the target user, artifact type, app surface, persistence plan, trust model, human-in-loop boundary, non-goals, and demo acceptance. Do not write code until those decisions are explicit.
```
