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

```bash
cd /path/to/challenge-repo
~/codex-fde-hack-kit/scripts/hackathon-bootstrap.sh .
```

If the challenge repo already has `AGENTS.md`, the installer will not overwrite it blindly. Read the existing file first and merge only the useful parts underneath the repo's own instructions.

## Start Codex

```bash
cd /path/to/challenge-repo
codex
```

## First Prompts

```text
Inspect this repo, explain the architecture, identify commands, and do not edit yet.
```

```text
Prepare problem-owner questions before we choose what to build.
```

```text
Frame the smallest useful vertical slice with non-goals, validation, and demo plan.
```

## Fast Script Loop

```bash
~/codex-fde-hack-kit/scripts/codex-analyze.sh
~/codex-fde-hack-kit/scripts/codex-interview-plan.sh "Prepare questions for the problem owner"
~/codex-fde-hack-kit/scripts/codex-plan.sh "Frame the smallest useful slice"
~/codex-fde-hack-kit/scripts/codex-implement.sh
~/codex-fde-hack-kit/scripts/codex-review.sh
~/codex-fde-hack-kit/scripts/codex-demo.sh
~/codex-fde-hack-kit/scripts/codex-retro.sh "Capture one lesson, one non-promotion, and one next adjustment"
```

## 90 Minute Onsite Loop

```text
00-10: inspect repo, commands, data, existing instructions
10-20: ask problem-owner questions and define operator pain
20-30: choose smallest useful slice, non-goals, and demo signal
30-65: implement the slice, stopping scope expansion aggressively
65-75: run tests/checks and fix only must-fix failures
75-85: prepare demo note: pain, input, tool, output, trust, next
85-90: run a 3-minute retrospective and capture one next adjustment
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
