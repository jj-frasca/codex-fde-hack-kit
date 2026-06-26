#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required=(
  "EVENT_DAY_BUNDLE.md"
  "EVENT_DAY_CARD.md"
  "DAY_OF.md"
  "README.md"
  "hackathon_quickstart.md"
  "docs/day_schedule.md"
  "docs/day_of_access_strategy.md"
  "docs/repo_context_workflow.md"
  "docs/agent_spec_template.md"
  "docs/culture_fit_interview_prep.md"
  "docs/evaluator_walkup_answers.md"
  "docs/context_preservation_during_interruption.md"
  "docs/codex_operating_model.md"
  "docs/board_driven_execution.md"
  "docs/client_trust_demo_guide.md"
  "docs/private_context_workflow.md"
  "AGENTS.md"
  "AGENTS.global.md"
  "agent_team_board.md"
  "prompts/01_repo_triage.md"
  "prompts/02a_problem_show_capture.md"
  "prompts/02_problem_owner_interview.md"
  "prompts/03a_paired_execution_plan.md"
  "prompts/04a_artifact_selector.md"
  "prompts/09_project_recap_followup.md"
  "prompts/07_demo_prep.md"
  "prompts/12_adversarial_review_board.md"
  "prompts/13_codex_operating_system_review.md"
  "prompts/14_client_trust_demo.md"
  "prompts/15_private_context_guard.md"
  "prompts/16_agent_spec_document.md"
  "prompts/17_culture_fit_interview.md"
  "prompts/18_evaluator_walkup.md"
  "prompts/19_demo_timebox_variants.md"
  "prompts/20_repo_context_builder.md"
  "skills/problem-owner-discovery/SKILL.md"
  "skills/paired-hackathon-execution/SKILL.md"
  "scripts/install-into-target-repo.sh"
  "scripts/codex-interview-plan.sh"
  "scripts/codex-demo.sh"
  "scripts/codex-agent-board-review.sh"
  "scripts/pre-push-check.sh"
  "scripts/hackathon-bootstrap.sh"
  "scripts/install-session-handoff.sh"
  "scripts/install-event-harness.sh"
  "scripts/install-kit-in-target-repo.sh"
  "scripts/protect-challenge-repo.sh"
  "scripts/init-private-context.sh"
  "scripts/codex-repo-context.sh"
  "scripts/codex-deep-dive.sh"
  "scripts/public-safety-scan.sh"
  ".agents/skills/repo-deep-dive/SKILL.md"
  ".agents/skills/repo-deep-dive/scripts/repo_inventory.sh"
  ".agents/skills/repo-deep-dive/references/report_schema.md"
  ".codex/agents/problem-framer.toml"
  ".codex/agents/architecture-mapper.toml"
  ".codex/agents/product-slice-finder.toml"
  ".codex/agents/reliability-reviewer.toml"
  ".codex/agents/security-privacy-reviewer.toml"
  ".codex/agents/dx-setup-reviewer.toml"
  ".codex/agents/maintainability-reviewer.toml"
  ".codex/agents/red-team.toml"
)

for path in "${required[@]}"; do
  if [[ ! -f "$ROOT/$path" ]]; then
    echo "Missing required file: $path" >&2
    exit 1
  fi
done

if git -C "$ROOT" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  for path in "${required[@]}"; do
    if ! git -C "$ROOT" ls-files --error-unmatch "$path" >/dev/null 2>&1; then
      echo "Required file is not staged/tracked by git: $path" >&2
      exit 1
    fi
  done
fi

bash -n "$ROOT"/scripts/*.sh
bash -n "$ROOT"/.agents/skills/repo-deep-dive/scripts/*.sh

TMP_HOME="$(mktemp -d)"
TMP_REPO="$(mktemp -d)"
cleanup() {
  rm -rf "$TMP_HOME" "$TMP_REPO"
}
trap cleanup EXIT

HOME="$TMP_HOME" CODEX_HOME="$TMP_HOME/.codex" "$ROOT/scripts/install-event-harness.sh" >/dev/null

for path in \
  "$TMP_HOME/.codex/onsite-safe.config.toml" \
  "$TMP_HOME/.codex/skills/repo-deep-dive/SKILL.md" \
  "$TMP_HOME/.agents/skills/repo-deep-dive/SKILL.md" \
  "$TMP_HOME/.codex/agents/problem-framer.toml" \
  "$TMP_HOME/.codex/agents/architecture-mapper.toml"; do
  if [[ ! -f "$path" ]]; then
    echo "Harness install smoke failed, missing: $path" >&2
    exit 1
  fi
done

git -C "$TMP_REPO" init -q
"$ROOT/scripts/init-private-context.sh" "$TMP_REPO" >/dev/null

if [[ ! -f "$TMP_REPO/.codex-private/hackathon_context.md" ]]; then
  echo "Private-context smoke failed: missing .codex-private/hackathon_context.md" >&2
  exit 1
fi

if ! grep -qxF ".codex-private/" "$TMP_REPO/.git/info/exclude"; then
  echo "Private-context smoke failed: .codex-private/ not added to local git exclude" >&2
  exit 1
fi

"$ROOT/scripts/install-kit-in-target-repo.sh" "$TMP_REPO" >/dev/null

if [[ ! -f "$TMP_REPO/.codex-kit/codex-fde-hack-kit/EVENT_DAY_BUNDLE.md" ]]; then
  echo "Embedded-kit smoke failed: missing EVENT_DAY_BUNDLE.md" >&2
  exit 1
fi

if [[ ! -f "$TMP_REPO/.codex-kit/codex-fde-hack-kit/EVENT_DAY_CARD.md" ]]; then
  echo "Embedded-kit smoke failed: missing EVENT_DAY_CARD.md" >&2
  exit 1
fi

if [[ ! -f "$TMP_REPO/.codex-kit/codex-fde-hack-kit/DAY_OF.md" ]]; then
  echo "Embedded-kit smoke failed: missing DAY_OF.md" >&2
  exit 1
fi

if ! grep -qxF ".codex-kit/" "$TMP_REPO/.git/info/exclude"; then
  echo "Embedded-kit smoke failed: .codex-kit/ not added to local git exclude" >&2
  exit 1
fi

if ! grep -qxF ".codex-working/" "$TMP_REPO/.git/info/exclude"; then
  "$ROOT/scripts/protect-challenge-repo.sh" "$TMP_REPO" >/dev/null
fi

if ! grep -qxF ".codex-working/" "$TMP_REPO/.git/info/exclude"; then
  echo "Embedded-kit smoke failed: .codex-working/ not added to local git exclude" >&2
  exit 1
fi

"$ROOT/scripts/codex-repo-context.sh" "$TMP_REPO" >/dev/null

if [[ ! -f "$TMP_REPO/.codex-working/REPO_CONTEXT.md" ]]; then
  echo "Repo-context smoke failed: missing .codex-working/REPO_CONTEXT.md" >&2
  exit 1
fi

if [[ ! -f "$TMP_REPO/.codex-working/repo_inventory.txt" ]]; then
  echo "Repo-context smoke failed: missing .codex-working/repo_inventory.txt" >&2
  exit 1
fi

private_marker="PRIVATE_""CONTEXT"
if rg -n "\.codex-private|\.codex-kit|$private_marker" "$TMP_REPO/.codex-working" >/dev/null; then
  echo "Repo-context smoke failed: protected local paths leaked into generated context" >&2
  exit 1
fi

"$ROOT/scripts/public-safety-scan.sh" "$TMP_REPO" >/dev/null

if git -C "$TMP_REPO" ls-files .codex-kit .codex-working .codex-private .private private-notes EVENT_DAY_BUNDLE.md EVENT_DAY_CARD.md | grep . >/dev/null; then
  echo "Embedded-kit smoke failed: protected files are tracked" >&2
  exit 1
fi

echo "Smoke check passed."
