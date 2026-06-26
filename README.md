# Codex FDE Hack Kit

Lightweight Codex-native operating kit for a Forward Deployed GenAI Engineer hackathon. It contains no proprietary company data. It gives you portable instructions, prompts, skills, and scripts for moving quickly in an unfamiliar challenge repo.

This differs from `claude-setup`: that repo can inspire structure, but this kit is built around Codex repo instructions (`AGENTS.md`), Codex-facing prompt wrappers, and git worktrees.

Core loop:

```text
problem show -> owner questions -> artifact choice -> paired plan -> smallest useful slice -> implement -> pressure-test -> verify -> demo -> project recap
```

Operating thesis:

```text
Use Codex as an execution system, not just a prompt box.
```

Use Codex as an execution system with preserved context, explicit goals, bounded delegation, visible guardrails, and tight verification loops. Optimize the final artifact for client trust and non-coder usefulness.

Board-first rule:

```text
Use specialist boards for problem framing, architecture/slice decisions, implementation review, and pre-demo trust checks. Keep one main integrator responsible for code edits.
```

See `docs/board_driven_execution.md`.

## Day-Of Brief

Use this as the first file for Codex and the human operator:

```bash
DAY_OF.md
```

It contains the event-day operating model, discovery capture, one-page spec shape, build loop, review board, demo shape, setup fallbacks, and contamination checks.

If GitHub, install, or skill discovery is blocked, use the shorter `EVENT_DAY_CARD.md` first and `EVENT_DAY_BUNDLE.md` when you need more detail.

## Install Global Instructions

```bash
./scripts/install-global-agents.sh
```

This copies `AGENTS.global.md` to `~/.codex/AGENTS.md`.

## Install Session Handoff

```bash
./scripts/install-session-handoff.sh "$HOME/CODEX_SESSION_HANDOFF.md"
```

This installs global handoff instructions plus lightweight `SessionStart` and `Stop` hooks. If Codex asks you to trust the hooks in a new session, run `/hooks` and approve them after reviewing the commands.

## Install Into A Target Repo

From this repo:

```bash
./scripts/install-into-target-repo.sh /path/to/challenge-repo
```

If the target repo already has `AGENTS.md`, read it first and merge carefully. The target repo's instructions should take priority.

## Install Event Harness

Use this on a clean event machine after cloning the kit. It installs the portable `repo-deep-dive` skill to `~/.agents/skills` and `~/.codex/skills`, installs specialist agent role prompts to `~/.codex/agents`, and writes an `onsite-safe` Codex profile. If that profile already exists, the script backs it up first.

```bash
~/codex-fde-hack-kit/scripts/install-event-harness.sh
```

Then, from a challenge repo:

```bash
codex --profile onsite-safe
```

Prompt:

```text
Use $repo-deep-dive with a specialist board. Inspect this repo deeply, explain the architecture, find flaws, and recommend the best one-day hackathon slice.
```

If Codex does not discover the new skill until restart, reference `~/.codex/skills/repo-deep-dive/SKILL.md` directly in the prompt or use the wrapper below.

Fast wrapper:

```bash
~/codex-fde-hack-kit/scripts/codex-deep-dive.sh /path/to/challenge-repo
```

The wrapper enforces a read-only sandbox for the first repository pass.

Then create the shared working repo map:

```bash
~/codex-fde-hack-kit/scripts/codex-repo-context.sh /path/to/challenge-repo
```

This writes ignored `.codex-working/REPO_CONTEXT.md` inside the challenge repo so fresh sessions and agents can start from the same architecture, command, data, and extension-point context.
It is deterministic: it updates local git excludes, runs repo inventory, and does not run Codex or modify app code. Timebox it to 5-10 minutes on event day.
Treat the first file as a scaffold plus inventory. Ask Codex to refine the TODO sections from repo evidence before relying on it for architecture decisions.

## Access And Fallbacks

Prefer cloning the public kit outside the challenge repo:

```bash
cd ~
git clone https://github.com/<your-github-user>/codex-fde-hack-kit.git
```

If you need the kit physically inside the challenge repo, embed it under ignored `.codex-kit/`:

```bash
~/codex-fde-hack-kit/scripts/install-kit-in-target-repo.sh /path/to/challenge-repo
```

This keeps the public kit available from the codebase without committing it. If GitHub or install is blocked, use `EVENT_DAY_CARD.md` first and `EVENT_DAY_BUNDLE.md` when you need more detail.

See `docs/day_of_access_strategy.md`.

## Private Context

Do not put event-specific private context in this public repo. Use an ignored local file instead:

```bash
~/codex-fde-hack-kit/scripts/init-private-context.sh /path/to/challenge-repo
```

Then tell Codex to read `.codex-private/hackathon_context.md` as private context and not copy it into repo files, commits, logs, public docs, or demo artifacts.

See `docs/private_context_workflow.md`.

## Day-Of Command Loop

Run these from the target repo you want Codex to work on:

```bash
/path/to/codex-fde-hack-kit/scripts/codex-analyze.sh
/path/to/codex-fde-hack-kit/scripts/codex-repo-context.sh .
/path/to/codex-fde-hack-kit/scripts/codex-interview-plan.sh "Prepare questions for the problem owner"
/path/to/codex-fde-hack-kit/scripts/codex-plan.sh "Build the smallest useful ops tool for this workflow"
/path/to/codex-fde-hack-kit/scripts/codex-implement.sh
/path/to/codex-fde-hack-kit/scripts/codex-debug.sh "Fix the failing smoke check"
/path/to/codex-fde-hack-kit/scripts/codex-review.sh
/path/to/codex-fde-hack-kit/scripts/codex-demo.sh
```

## Pre-Push Adversarial Review

Before pushing or demoing, run automated checks and then the agent board:

```bash
/path/to/codex-fde-hack-kit/scripts/pre-push-check.sh /path/to/target-repo
/path/to/codex-fde-hack-kit/scripts/codex-agent-board-review.sh /path/to/target-repo
```

The board uses focused roles: problem framing, architecture, product/demo, reliability, security/privacy, DX/setup, maintainability, and red team. Fix blockers first.

## Hackathon Use

1. Clone this repo.
2. Clone or open the challenge repo.
3. Install the event harness.
4. Start Codex with `codex --profile onsite-safe`.
5. Use `$repo-deep-dive` before editing.
6. Convert discovery notes into a one-page agent/tool spec.
7. Choose one useful vertical slice.
8. Implement, verify, summarize the diff, and iterate.

Fast bootstrap:

```bash
~/codex-fde-hack-kit/scripts/hackathon-bootstrap.sh /path/to/challenge-repo
```

Use bootstrap only when you intentionally want to add repo-level instructions. For event day, prefer `install-event-harness.sh` or the ignored `.codex-kit/` embed path.

See `hackathon_quickstart.md` for the clean-machine flow.

## Spec Block

The critical early window is:

```text
user discovery -> one-page agent/tool spec -> smallest useful build
```

Use:

- `docs/day_schedule.md`
- `docs/repo_context_workflow.md`
- `docs/agent_spec_template.md`
- `prompts/16_agent_spec_document.md`
- `prompts/18_evaluator_walkup.md`
- `prompts/19_demo_timebox_variants.md`

## Safety

- Do not commit proprietary company data, code, screenshots, or private challenge materials.
- Do not commit `.codex-kit/`, `.codex-working/`, private notes, credentials, or local event context.
- Do not run Codex in a workspace another tool or teammate is actively editing. Use a worktree.
- Use subagents for bounded read-heavy work and reviews; keep one integrator for implementation.
- Prefer deterministic rules and auditable workflows before LLM-based automation.
- Treat people, community, and regulatory outputs as decision support, not final authority.
