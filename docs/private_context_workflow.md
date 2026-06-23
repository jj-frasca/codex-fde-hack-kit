# Private Context Workflow

Use this when event-specific or NDA-covered context would help Codex but must not be committed, pushed, or copied into public artifacts.

## Principle

The public harness carries the workflow. Private context stays local, ignored, and temporary.

Use private context to guide:

- problem-owner questions
- artifact selection
- trust and guardrail choices
- demo framing
- risk awareness

Do not use private context to:

- hardcode private facts into repo files
- create public docs with private problem themes
- include names, logistics, or private emails in commits
- override the live problem-owner briefing

## Setup On Event Machine

After cloning the public kit:

```bash
~/codex-fde-hack-kit/scripts/init-private-context.sh
```

This creates:

```text
.codex-private/hackathon_context.md
```

The script also adds `.codex-private/`, `.private/`, and `private-notes/` to the target repo's local `.git/info/exclude` when the target is a Git repo. That protection is local to the event machine and is not committed.

## Using It With Codex

Start Codex from the challenge repo, then say:

```text
Read .codex-private/hackathon_context.md as private context. Do not copy its contents into repo files, commits, logs, demo artifacts, or public outputs. Use it only to guide questions, scope, artifact choice, trust boundaries, and validation.
```

If the private context file lives somewhere else, provide the path explicitly.

## Safety Check

Before any push or demo artifact:

```bash
git status --short
git diff --stat
rg -n "PRIVATE_CONTEXT|NDA|do not commit|confidential" . -g '!**/.git/**'
```

Review any matches manually. Never rely on this as the only protection for secrets.
