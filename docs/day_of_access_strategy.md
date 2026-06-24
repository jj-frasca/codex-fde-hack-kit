# Day-Of Access Strategy

Default to the lowest-contamination path that works.

## Recommended Order

1. Public HTTPS clone outside the challenge repo.
2. Public kit embedded under ignored `.codex-kit/` inside the challenge repo.
3. No-install Codex session with prompts pasted manually.
4. Printed or preloaded `EVENT_DAY_BUNDLE.md`.

Do not depend on private repo access on event day unless the rules explicitly allow it.

## Tier 1: Outside-Repo Public Kit

```bash
cd ~
git clone https://github.com/<your-github-user>/codex-fde-hack-kit.git
~/codex-fde-hack-kit/scripts/install-event-harness.sh
cd /path/to/challenge-repo
codex --profile onsite-safe
```

This is the preferred path because the kit is not inside the challenge repo and cannot be accidentally committed.

## Tier 2: Ignored Kit Inside Challenge Repo

Use this when you need the kit physically available inside the codebase, but it must not be committed.

```bash
~/codex-fde-hack-kit/scripts/install-kit-in-target-repo.sh /path/to/challenge-repo
cd /path/to/challenge-repo
.codex-kit/codex-fde-hack-kit/scripts/protect-challenge-repo.sh .
```

This creates:

```text
.codex-kit/codex-fde-hack-kit/
```

and adds these local-only excludes:

```text
.codex-kit/
.codex-private/
.private/
private-notes/
EVENT_DAY_BUNDLE.md
```

Always check before commit:

```bash
git status --short
git ls-files .codex-kit .codex-private .private private-notes EVENT_DAY_BUNDLE.md
```

The second command should print nothing.

## Tier 3: No Install

If `~/.codex`, `~/.agents`, hooks, profiles, or shell scripts are blocked:

```bash
cd /path/to/challenge-repo
codex -c 'sandbox_mode="workspace-write"' -c 'approval_policy="on-request"' -c 'model_reasoning_effort="medium"'
```

Paste prompts from `EVENT_DAY_BUNDLE.md`.

## Tier 4: No GitHub

Use a preloaded or printed copy of `EVENT_DAY_BUNDLE.md`. If event rules allow a file transfer, place the bundle outside the challenge repo or under ignored `.codex-kit/`.

## What Never Belongs In The Challenge Commit

- `codex-fde-hack-kit`
- `fde-ops-lab`
- `.codex-kit/`
- `.codex-private/`
- private notes
- credentials
- private event logistics
- private practice scenarios
- personal access tokens
