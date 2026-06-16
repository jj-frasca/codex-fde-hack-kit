# Codex FDE Hack Kit

Lightweight Codex-native operating kit for a Forward Deployed GenAI Engineer hackathon. It contains no proprietary company data. It gives you repeatable instructions, prompts, scripts, sample data, and practice scenarios for moving quickly in unfamiliar repos.

This differs from `claude-setup`: that repo can inspire structure, but this kit is built around Codex repo instructions (`AGENTS.md`), Codex-facing prompt wrappers, and git worktrees.

Core loop:

```text
inspect -> ask problem-owner questions -> smallest useful slice -> plan -> implement -> verify -> demo -> summarize diff -> retrospective -> improve harness
```

## Install Global Instructions

```bash
./scripts/install-global-agents.sh
```

This copies `AGENTS.global.md` to `~/.codex/AGENTS.md`.

## Install Into A Target Repo

From this repo:

```bash
./scripts/install-into-target-repo.sh /path/to/challenge-repo
```

If the target repo already has `AGENTS.md`, read it first and merge carefully. The target repo's instructions should take priority.

## Worktree Isolation

Use a git worktree so Codex does not interfere with another agent or editor session.

```bash
./scripts/create-worktree.sh /path/to/source-repo practice/scenario ../practice-worktree
cd ../practice-worktree
codex
```

Remove later:

```bash
./scripts/remove-worktree.sh ../practice-worktree
```

## Practice Loop Commands

Run these from the target repo you want Codex to work on:

```bash
/path/to/codex-fde-hack-kit/scripts/codex-analyze.sh
/path/to/codex-fde-hack-kit/scripts/codex-interview-plan.sh "Prepare questions for the problem owner"
/path/to/codex-fde-hack-kit/scripts/codex-plan.sh "Build the smallest useful ops tool for this workflow"
/path/to/codex-fde-hack-kit/scripts/codex-implement.sh
/path/to/codex-fde-hack-kit/scripts/codex-debug.sh "Fix the failing smoke check"
/path/to/codex-fde-hack-kit/scripts/codex-review.sh
/path/to/codex-fde-hack-kit/scripts/codex-demo.sh
/path/to/codex-fde-hack-kit/scripts/codex-retro.sh "Review the practice rep"
```

## Pre-Push Adversarial Review

Before pushing or demoing, run automated checks and then the agent board:

```bash
/path/to/codex-fde-hack-kit/scripts/pre-push-check.sh /path/to/target-repo
/path/to/codex-fde-hack-kit/scripts/codex-agent-board-review.sh /path/to/target-repo
```

The board uses focused roles: problem framing, product/demo, reliability, security/privacy, maintainability, and red team. Fix blockers first. Do not promote new durable instructions unless the retrospective evidence justifies it.

## Retrospective Loop

After each practice rep, write one concise retrospective:

```bash
/path/to/codex-fde-hack-kit/scripts/codex-retro.sh
```

Only promote durable lessons after repeated evidence:

```bash
/path/to/codex-fde-hack-kit/scripts/codex-promote-rule.sh
```

Do not promote one-off scenario details, vague preferences, duplicate rules, or instructions that conflict with a target repo's `AGENTS.md`.

## Hackathon Use

1. Clone this repo.
2. Clone or open the challenge repo.
3. Install project instructions into the challenge repo.
4. Ask Codex to inspect before editing.
5. Choose one useful vertical slice.
6. Implement, verify, summarize the diff, and iterate.

Fast bootstrap:

```bash
~/codex-fde-hack-kit/scripts/hackathon-bootstrap.sh /path/to/challenge-repo
```

See `hackathon_quickstart.md` for the clean-machine flow.

## Safety

- Do not commit proprietary company data, code, screenshots, or private challenge materials.
- Do not run Codex in a workspace another tool or teammate is actively editing. Use a worktree.
- Prefer deterministic rules and auditable workflows before LLM-based automation.
- Treat people, community, and regulatory outputs as decision support, not final authority.
