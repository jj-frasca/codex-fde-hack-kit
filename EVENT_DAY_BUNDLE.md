# Event Day Bundle

Use this if GitHub, private repos, user-level install, or skill discovery is blocked. If time is extremely short, use `EVENT_DAY_CARD.md` first.

Keep this file outside the challenge repo unless event rules require a local copy. If copied into the challenge repo, put it under `.codex-kit/` and make sure `.codex-kit/` is in `.git/info/exclude`.

## Access Tiers

### Tier 1: Public GitHub Works

```bash
cd ~
git clone https://github.com/<your-github-user>/codex-fde-hack-kit.git
~/codex-fde-hack-kit/scripts/install-event-harness.sh
cd /path/to/challenge-repo
codex --profile onsite-safe
```

### Tier 2: Public Kit Inside Challenge Repo

Use only if you need the kit physically inside the challenge repo for local access. This installs the public kit under an ignored `.codex-kit/` directory.

```bash
~/codex-fde-hack-kit/scripts/install-kit-in-target-repo.sh /path/to/challenge-repo
cd /path/to/challenge-repo
.codex-kit/codex-fde-hack-kit/scripts/protect-challenge-repo.sh .
codex --profile onsite-safe
```

Run kit scripts by path:

```bash
.codex-kit/codex-fde-hack-kit/scripts/codex-deep-dive.sh .
.codex-kit/codex-fde-hack-kit/scripts/pre-push-check.sh .
```

### Tier 3: No Install

```bash
cd /path/to/challenge-repo
codex -c 'sandbox_mode="read-only"' -c 'approval_policy="on-request"' -c 'model_reasoning_effort="xhigh"'
```

Paste the first prompt below manually. Restart with `sandbox_mode="workspace-write"` only after the slice is chosen.

### Tier 4: No GitHub

Use a preloaded or printed copy of this bundle. Do not clone private practice repos unless event rules explicitly allow it.

## First Prompt

```text
Inspect this repo deeply before editing. Explain the architecture, entrypoints, commands, tests, data flow, risks, and likely smallest useful one-day slice. Use a specialist board with these roles: problem framing, architecture, product/demo, reliability, security/privacy, DX/setup, maintainability, and red team. Stay read-only until I choose the slice.
```

## Problem-Owner Capture

```text
Turn the problem-owner briefing into a buildable plan.

Return:

Problem owner:
Current workflow:
Pain:
Desired outcome:
Trusted inputs:
Useful output:
Constraints:
Risk if wrong:
Smallest useful artifact:
Non-goals:
Validation:
Demo path:
Open questions:
```

## Agent / Tool Spec

```text
Using the problem-owner discovery notes, create a concise agent/tool spec suitable for sharing with evaluators.

Use:

- Problem Owner
- User / Client
- Current Workflow
- Pain / Bottleneck
- Trusted Inputs
- Desired Output
- Proposed Artifact
- Smallest Useful Version
- Explicit Non-Goals
- Workflow
- Guardrails / Trust
- Implementation Plan
- Validation Plan
- Demo Plan
- Open Questions

Keep it practical, not academic. Optimize for usefulness, trust, and demo feasibility.
```

## Implementation Prompt

```text
Implement only the agreed smallest useful slice. Inspect before editing. Keep the diff narrow. Do not add private context, secrets, credentials, local paths, or kit files to the repo. Add focused validation through tests, smoke checks, fixtures, or manual checks. After each meaningful change, summarize files touched, commands run, risk, and next step.
```

## Evaluator Walkup

```text
Prepare a 30-second evaluator update:

What we are building:
Why it matters:
What changed after owner feedback:
What works now:
How we are validating:
What is next:
Risk/limitation:
```

## Demo Variants

```text
Create demo scripts for 30 seconds, 3 minutes, and 5 minutes.

Each version should cover:

- client pain
- messy input
- tool/artifact
- useful output
- why it can be trusted
- human-in-loop guardrail
- next step

Avoid architecture-first language.
```

## Safety Checks

Before committing or demoing:

```bash
git status --short
git diff --check
git ls-files .codex-kit .codex-private .private private-notes EVENT_DAY_BUNDLE.md EVENT_DAY_CARD.md 2>/dev/null
git diff --cached --name-only | grep -E '(^|/)(\.codex-kit|\.codex-private|\.private|private-notes)(/|$)|(^|/)EVENT_DAY_(BUNDLE|CARD)\.md$' || true
```

No kit files, private notes, credentials, or private context should be staged.
