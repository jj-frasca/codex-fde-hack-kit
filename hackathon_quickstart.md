# Hackathon Quickstart

Use this when you get a fresh challenge repo and need the setup active immediately.

For the full agent/human operating brief, point Codex to `DAY_OF.md` first.

## Clone The Kit

Prefer HTTPS because SSH keys may not be available on a clean event machine:

```bash
cd ~
git clone https://github.com/<your-github-user>/codex-fde-hack-kit.git
```

If HTTPS is blocked but SSH is configured:

```bash
git clone git@github.com:<your-github-user>/codex-fde-hack-kit.git
```

## Bootstrap A Challenge Repo

For a portable user-level setup that does not modify the challenge repo, run:

```bash
~/codex-fde-hack-kit/scripts/install-event-harness.sh
```

Then start Codex from the challenge repo:

```bash
cd /path/to/challenge-repo
codex --profile onsite-safe
```

Use the deep-dive skill first:

```text
Use $repo-deep-dive with a specialist board. Inspect this repo deeply, explain the architecture, find flaws, and recommend the best one-day hackathon slice.
```

If skill discovery is stale, restart Codex or reference `~/.codex/skills/repo-deep-dive/SKILL.md` directly in the prompt.

If you also want to install project instructions into the repo:

```bash
cd /path/to/challenge-repo
~/codex-fde-hack-kit/scripts/hackathon-bootstrap.sh .
```

If the challenge repo already has `AGENTS.md`, the installer will not overwrite it blindly. Read the existing file first and merge only the useful parts underneath the repo's own instructions.

## If The Kit Must Live Inside The Challenge Repo

Use an ignored local embed. This gives you the kit from inside the codebase without staging it:

```bash
~/codex-fde-hack-kit/scripts/install-kit-in-target-repo.sh /path/to/challenge-repo
cd /path/to/challenge-repo
.codex-kit/codex-fde-hack-kit/scripts/protect-challenge-repo.sh .
```

Then run kit scripts by path:

```bash
.codex-kit/codex-fde-hack-kit/scripts/codex-deep-dive.sh .
.codex-kit/codex-fde-hack-kit/scripts/pre-push-check.sh .
```

Before every commit:

```bash
git status --short
git ls-files .codex-kit .codex-private .private private-notes EVENT_DAY_BUNDLE.md
```

The second command should print nothing.

## Start Codex

```bash
cd /path/to/challenge-repo
codex --profile onsite-safe
```

## First Prompts

```text
Use docs/board_driven_execution.md as the operating model. Run a discovery board first, then an architecture/slice board, and keep one main integrator for code edits.
```

```text
Capture the problem show using prompts/02a_problem_show_capture.md. Extract owner, workflow, pain, trusted inputs, useful output, constraints, risk, smallest useful artifact, validation, demo path, and open questions.
```

```text
Create the one-page agent/tool spec using prompts/16_agent_spec_document.md. Optimize for usefulness, trust, and demo feasibility.
```

```text
Create a paired execution plan using prompts/03a_paired_execution_plan.md. Split ownership clearly and keep one coherent artifact.
```

```text
Inspect this repo, explain the architecture, identify commands, and do not edit yet.
```

```text
Prepare problem-owner questions before we choose what to build.
```

```text
Frame the smallest useful vertical slice with non-goals, validation, and demo plan.
```

```text
Choose the best artifact type using prompts/04a_artifact_selector.md. Optimize for usefulness by demo time.
```

```text
Prepare a 30-second evaluator update using prompts/18_evaluator_walkup.md.
```

## Fast Script Loop

```bash
~/codex-fde-hack-kit/scripts/codex-analyze.sh
~/codex-fde-hack-kit/scripts/codex-interview-plan.sh "Prepare questions for the problem owner"
~/codex-fde-hack-kit/scripts/codex-plan.sh "Frame the smallest useful slice"
~/codex-fde-hack-kit/scripts/codex-implement.sh
~/codex-fde-hack-kit/scripts/codex-review.sh
~/codex-fde-hack-kit/scripts/codex-demo.sh
```

## Onsite Loop

```text
Arrive: follow event rules, be present, and observe operational context
Setup: read instructions, inspect repo shape, confirm commands
Problem show: capture owner, workflow, pain, constraints, desired outcome
Agent spec: write a one-page buildable spec before coding
First owner check-in: ask what is useful by demo time and what not to build
Pair alignment: split ownership, set sync checkpoints, keep one artifact
Board check: run discovery and architecture/slice roles before coding
Build block: implement smallest useful artifact, integrate early
Pressure tests: show intermediate output to owner and adapt scope
Verification: run focused checks and validate usefulness
Demo prep: run pre-demo board, then rehearse pain, input, artifact, output, trust, limits, next
Project recap: contribution, Codex usage, tradeoffs, production path
```

## Spec Block

The early operating sequence is:

```text
user discovery -> agent/tool spec -> build
```

Treat discovery and spec-writing as separate timeboxed blocks when the event schedule allows.

References:

- `docs/day_schedule.md`
- `docs/agent_spec_template.md`
- `docs/context_preservation_during_interruption.md`

## Before Push Or Demo

```bash
~/codex-fde-hack-kit/scripts/pre-push-check.sh .
~/codex-fde-hack-kit/scripts/codex-agent-board-review.sh .
```

## If GitHub Access Is Blocked

Use `EVENT_DAY_BUNDLE.md` or a printed copy. If file transfer is allowed, place the bundle outside the challenge repo or under ignored `.codex-kit/`.

No-install Codex:

```bash
cd /path/to/challenge-repo
codex -c 'sandbox_mode="workspace-write"' -c 'approval_policy="on-request"' -c 'model_reasoning_effort="xhigh"'
```

Then paste the bundle prompts manually.

At minimum, the bundle contains:

- `AGENTS.global.md` into `~/.codex/AGENTS.md`
- `AGENTS.md` into the challenge repo only after checking for an existing repo instruction file
- `prompts/`
- `agent_team_board.md`
- `scripts/public-safety-scan.sh`

Then run Codex from the challenge repo.
