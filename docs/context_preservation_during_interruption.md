# Context Preservation During Interruption

Use this before any interview, lunch, owner meeting, or unexpected pause.

## Protocol

Before leaving, update a local build-state note:

```md
# Build State

Current goal:
Current branch:
Commands to run:
What works:
What is broken:
Next action:
Open questions for owner:
Demo path:
```

Keep it in a local note, issue, or ignored file if it contains private challenge context.

## Return Prompt

```text
Read the current build-state note and git diff. Reconstruct the current goal, what works, what is broken, next action, open owner questions, validation plan, and demo path. Do not edit files until the next action is clear.
```

## Minimum Context To Preserve

- current branch or worktree
- last successful command
- failing command or open bug
- next file likely to edit
- next owner question
- exact demo path
