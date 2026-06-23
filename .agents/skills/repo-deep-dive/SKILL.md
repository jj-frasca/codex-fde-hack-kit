---
name: repo-deep-dive
description: Use when Codex needs a read-only, multi-angle inspection of an unfamiliar repository for a hackathon, onsite coding exercise, inherited codebase, or ambiguous product challenge. The skill inventories files, commands, entrypoints, tests, data, risks, and improvement opportunities, then synthesizes architecture, flaws, top one-day slices, owner questions, validation plan, and demo narrative. Do not use for implementation; use before editing.
---

# Repo Deep Dive

Run a bounded, read-only repo inspection that turns an unfamiliar codebase into an actionable hackathon plan. Do not edit files while using this skill unless the user explicitly asks to implement after the deep dive.

## Workflow

1. Confirm the repo root and current `git status --short`.
2. Run `scripts/repo_inventory.sh <repo-root>` from this skill directory.
3. Read `references/report_schema.md`.
4. Inspect only the highest-signal files from the inventory: instructions, README, manifests, entrypoints, tests, CI, data samples, env examples, and obvious extension points.
5. Run the specialist board by default. Spawn read-only subagents when the user asked for parallel agents and subagents are available; otherwise simulate the roles sequentially.
6. Synthesize findings into the report schema.
7. Stop before implementation. Ask the user to choose a slice if tradeoffs are material.

## Subagent Roles

Use these roles for independent read-only passes. Keep each prompt scoped and ask for concise findings with file references:

- Architecture Mapper: modules, entrypoints, data flow, external interfaces.
- Product / One-Day Slice Finder: top operator workflows and smallest demoable improvements.
- Reliability / Tests Reviewer: test coverage, brittle paths, missing validation, likely runtime failures.
- Security / Privacy Reviewer: secrets, PII, auth, unsafe logs, injection risks, dangerous defaults.
- DX / Setup Reviewer: setup commands, dependency friction, scripts, docs, local run path.
- Maintainability Reviewer: complexity, duplication, naming, coupling, overbuild risks.
- Red Team: strongest objections, likely demo failure, and mitigation.

Do not let subagents edit. If a subagent reports an implementation idea, capture it as a proposed slice, not a change.

## Inventory Rules

Prefer `rg` for searching. Keep raw inventory output short enough to scan. Do not print secret values. If suspicious secret-like patterns are found, report paths and line numbers only.

The inventory script is deterministic support, not the final analysis. Use judgment after reading the relevant files.

## Output

Follow `references/report_schema.md` exactly enough to be useful:

- architecture explanation
- commands and setup
- data and external interfaces
- key flaws and risks
- top three one-day improvements
- recommended smallest useful slice
- problem-owner questions
- validation plan
- demo narrative
- implementation guardrails

## Guardrails

- Stay read-only.
- Keep file references concrete.
- Bias toward one narrow vertical slice over broad refactors.
- Separate facts from inferences.
- Flag unknowns rather than guessing.
- Avoid private/company-specific speculation.
