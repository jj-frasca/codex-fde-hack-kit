# Hackathon Quickstart

Use this when you get a fresh challenge repo and need the setup active immediately.

## Clone The Kit

```bash
cd ~
git clone git@github.com:<your-github-user>/codex-fde-hack-kit.git
```

If SSH is not available:

```bash
git clone https://github.com/<your-github-user>/codex-fde-hack-kit.git
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
First owner check-in: ask what is useful by demo time and what not to build
Pair alignment: split ownership, set sync checkpoints, keep one artifact
Board check: run discovery and architecture/slice roles before coding
Build block: implement smallest useful artifact, integrate early
Pressure tests: show intermediate output to owner and adapt scope
Verification: run focused checks and validate usefulness
Demo prep: run pre-demo board, then rehearse pain, input, artifact, output, trust, limits, next
Project recap: contribution, Codex usage, tradeoffs, production path
```

## Before Push Or Demo

```bash
~/codex-fde-hack-kit/scripts/pre-push-check.sh .
~/codex-fde-hack-kit/scripts/codex-agent-board-review.sh .
```

## If GitHub Access Is Blocked

Bring a local copy on your machine. At minimum, copy:

- `AGENTS.global.md` into `~/.codex/AGENTS.md`
- `AGENTS.md` into the challenge repo only after checking for an existing repo instruction file
- `prompts/`
- `agent_team_board.md`
- `scripts/public-safety-scan.sh`

Then run Codex from the challenge repo.
