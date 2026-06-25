# Day-Of Operating Brief

Use this file as the first thing Codex reads during an onsite build exercise.

It has two jobs:

1. Tell the agent how to operate.
2. Give the human operator a short command map.

Do not add private event details, proprietary data, personal notes, or company-specific repo information to this file.

## Run This First

```bash
~/codex-fde-hack-kit/scripts/install-event-harness.sh
cd /path/to/challenge-repo
~/codex-fde-hack-kit/scripts/codex-deep-dive.sh .
```

Then choose the smallest useful slice, start Codex with `codex --profile onsite-safe`, and implement only after the first read-only pass is complete.

## Agent Brief

You are helping in a live FDE-style hackathon. Your job is not to produce the broadest possible system. Your job is to help turn a messy real workflow into one useful, validated artifact that a problem owner can trust.

Operate like this:

```text
inspect -> ask owner questions -> write spec -> choose smallest useful slice -> implement -> verify -> review -> demo -> recap
```

Core rules:

- Inspect before editing.
- For ambiguous work, plan before coding. Use `/plan` when available, or explicitly ask for a plan first.
- Use maximum reasoning effort for planning, architecture, review, safety, and demo-critical decisions.
- Keep one main integrator responsible for code edits.
- Use specialist boards for read-heavy analysis, architecture decisions, reliability/security review, and demo review.
- Prefer one narrow vertical slice over a broad platform.
- Optimize for usefulness, trust, non-coder clarity, and demo feasibility.
- Show evidence: source references, reason codes, tests, smoke checks, audit trails, or manual validation.
- Keep humans in the loop for high-impact decisions.
- Do not commit private notes, credentials, local paths, kit files, private context, or proprietary material.
- After every meaningful change, summarize files touched, commands run, verification, risks, and next step.

## First Agent Action

From the challenge repo, start read-only:

```text
Read DAY_OF.md if available, then inspect this repo deeply before editing. Explain the architecture, entrypoints, commands, tests, data flow, risks, and likely smallest useful one-day slice. Use a specialist board with these roles: problem framing, architecture, product/demo, reliability, security/privacy, DX/setup, maintainability, and red team. Stay read-only until I choose the slice.
```

If the `repo-deep-dive` skill is available:

```text
Use $repo-deep-dive with a specialist board. Inspect this repo deeply, explain the architecture, find flaws, and recommend the best one-day hackathon slice. Do not edit yet.
```

## Plan-First Prompt Contract

For any ambiguous or high-stakes task, use this structure before implementation:

```text
Goal:
Context:
Constraints:
Done when:
```

Default day-of example:

```text
Goal: Build the smallest useful artifact for this problem owner by demo time.
Context: Use the challenge repo, owner discovery notes, trusted inputs, current workflow, and existing code patterns.
Constraints: Inspect before editing, keep one main integrator, avoid private data leaks, preserve human review, do not overbuild, and verify outputs.
Done when: The artifact runs on representative input, produces a useful output, has a validation path, includes guardrails/limitations, and can be demoed clearly to a non-coder.
```

If the task has many steps, use a persistent goal when available:

```text
/goal Build and validate the agreed smallest useful artifact. Done when the demo path works, focused checks pass, risks are summarized, and no private/kit files are staged.
```

Use `/plan` before code when the owner problem, repo architecture, or artifact choice is still unclear.

## Discovery Capture

During problem-owner discovery, capture:

```text
Problem owner:
User/client:
Current workflow:
Pain/bottleneck:
Trusted inputs:
Messy or unreliable inputs:
Useful output:
Constraints:
Risk if wrong:
Smallest useful artifact:
Explicit non-goals:
Validation path:
Demo path:
Open questions:
```

Ask these questions if unclear:

- Who is the exact user?
- What decision or action are they trying to take?
- What happens today before this tool exists?
- Which inputs are trusted, messy, stale, sensitive, or missing?
- What must never happen?
- What is the cost of a false positive versus false negative?
- Who approves, overrides, or audits the result?
- What would be useful by demo time?
- What should we explicitly not build?

## Agent / Tool Spec

Before coding, produce a one-page spec:

```text
Problem Owner:
User / Client:
Current Workflow:
Pain / Bottleneck:
Trusted Inputs:
Desired Output:
Proposed Artifact:
Smallest Useful Version:
Explicit Non-Goals:
Workflow:
Guardrails / Trust:
Implementation Plan:
Validation Plan:
Demo Plan:
Open Questions:
```

The spec should be practical, not academic. It should explain why this artifact is the right one for the timebox.

## Artifact Selection

Prefer artifacts that make one workflow meaningfully easier:

- CLI/script
- decision aid
- report generator
- dashboard
- Slack/webhook workflow
- data reconciliation tool
- document review tool
- lightweight operating system/tracker

Choose based on:

- what the owner will actually use
- what can be built by demo time
- what can be validated
- what can be explained clearly
- what keeps unsafe automation out of the critical path

Avoid:

- broad command centers
- generic chatbots with no workflow
- autonomous actions without review
- dashboards that only look complete
- architecture-first demos

## Build Loop

For implementation:

1. Inspect relevant files.
2. Identify existing patterns.
3. Patch narrowly.
4. Run focused checks.
5. Show intermediate output to the owner when possible.
6. Adjust scope based on owner feedback.
7. Keep a demo path working at all times.

Use this implementation prompt:

```text
Implement only the agreed smallest useful slice. Inspect before editing. Keep the diff narrow. Follow existing repo patterns. Do not add private context, secrets, credentials, local paths, or kit files. Add focused validation through tests, smoke checks, fixtures, or manual checks. After each meaningful change, summarize files touched, commands run, risk, and next step.
```

## Review Board

Before demo or push, run a review with these roles:

- Problem Framer: Does this solve the actual workflow pain?
- Architecture Mapper: Is the implementation placed correctly?
- Product/Demo: Is the artifact useful and demoable?
- Reliability: Are checks, tests, and edge cases adequate?
- Security/Privacy: Are secrets, private data, unsafe automation, and prompt-injection risks controlled?
- DX/Setup: Can someone run it?
- Maintainability: Is the diff small and explainable?
- Red Team: What is the strongest objection?

Fix blockers first. Do not expand scope unless the blocker requires it.

## Demo Shape

Demo in this order:

```text
Pain -> messy input -> tool/artifact -> useful output -> why it can be trusted -> human-in-loop -> next step
```

Prepare 30-second, 3-minute, and 5-minute versions.

Never lead with architecture unless asked.

## Interruption Protocol

Before lunch, interviews, owner meetings, or unexpected pauses, write:

```text
Current goal:
Current branch:
Commands to run:
What works:
What is broken:
Next action:
Open questions for owner:
Demo path:
```

When returning, ask Codex:

```text
Read the build-state note and git diff. Reconstruct current goal, what works, what is broken, next action, open owner questions, validation plan, and demo path. Do not edit files until the next action is clear.
```

## Human Quickstart

Preferred setup, outside the challenge repo:

```bash
cd ~
git clone https://github.com/<your-github-user>/codex-fde-hack-kit.git
~/codex-fde-hack-kit/scripts/install-event-harness.sh
cd /path/to/challenge-repo
codex --profile onsite-safe
```

If the kit must live inside the challenge repo:

```bash
~/codex-fde-hack-kit/scripts/install-kit-in-target-repo.sh /path/to/challenge-repo
cd /path/to/challenge-repo
.codex-kit/codex-fde-hack-kit/scripts/protect-challenge-repo.sh .
```

Run embedded kit commands:

```bash
.codex-kit/codex-fde-hack-kit/scripts/codex-deep-dive.sh .
.codex-kit/codex-fde-hack-kit/scripts/pre-push-check.sh .
```

If GitHub or install is blocked:

```bash
cd /path/to/challenge-repo
codex -c 'sandbox_mode="workspace-write"' -c 'approval_policy="on-request"' -c 'model_reasoning_effort="xhigh"'
```

Then paste prompts from `EVENT_DAY_BUNDLE.md`.

## Human Command Map

Use these from the challenge repo:

```bash
~/codex-fde-hack-kit/scripts/codex-deep-dive.sh .
~/codex-fde-hack-kit/scripts/codex-interview-plan.sh "Prepare problem-owner questions"
~/codex-fde-hack-kit/scripts/codex-plan.sh "Frame the smallest useful slice"
~/codex-fde-hack-kit/scripts/codex-implement.sh "Implement the agreed slice"
~/codex-fde-hack-kit/scripts/codex-review.sh
~/codex-fde-hack-kit/scripts/codex-demo.sh "Prepare the demo"
```

Before commit or demo:

```bash
~/codex-fde-hack-kit/scripts/pre-push-check.sh .
~/codex-fde-hack-kit/scripts/codex-agent-board-review.sh .
```

Check that kit/private files are not tracked:

```bash
git status --short
git ls-files .codex-kit .codex-private .private private-notes EVENT_DAY_BUNDLE.md
```

The second command should print nothing.

## What Not To Do

- Do not clone private practice repos unless rules explicitly allow it.
- Do not copy private prep into the challenge repo.
- Do not commit `.codex-kit/`, `.codex-private/`, `.private/`, private notes, local paths, screenshots with private context, credentials, or personal access tokens.
- Do not use `hackathon-bootstrap.sh` unless you intentionally want to modify the target repo.
- Do not let Codex keep coding after the demo path breaks; restore the demo path first.
- Do not build a broad platform when a narrow decision aid would be more useful.
