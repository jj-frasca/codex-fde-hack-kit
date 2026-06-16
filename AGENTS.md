# Codex Project Instructions

This repo is a lightweight hackathon harness. Keep changes simple, inspectable, and safe to publish.

## Before Editing

- Read `README.md` and relevant package/config files.
- Inspect the directory tree.
- Identify app entrypoints.
- Identify tests, build, lint, and smoke commands.
- Identify where the requested feature should live.
- Check current git status and avoid overwriting unrelated user work.

## Standard Analysis Format

```text
Understanding:
Problem-owner questions:
Target slice:
Plan:
Files likely touched:
Verification:
Risks / assumptions:
```

## Implementation Summary Format

```text
Changes made:
Files touched:
How to verify:
Commands run:
Known limitations:
Next iteration:
Demo angle:
```

## Working Style

- Prefer the smallest useful vertical slice.
- Keep diffs minimal and reversible.
- Add validation through tests, smoke commands, sample data, or manual checklists.
- Avoid broad rewrites and new dependencies unless clearly justified.
- Summarize commands run and residual risk.
- Never commit API keys, tokens, private contact details, or proprietary/private company information.
- Before public pushes, run the public-safety scan and an adversarial review board.
