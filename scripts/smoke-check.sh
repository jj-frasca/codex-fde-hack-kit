#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required=(
  "README.md"
  "hackathon_quickstart.md"
  "AGENTS.md"
  "AGENTS.global.md"
  "agent_team_board.md"
  "prompts/01_repo_triage.md"
  "prompts/02_problem_owner_interview.md"
  "prompts/07_demo_prep.md"
  "prompts/12_adversarial_review_board.md"
  "retrospectives/template.md"
  "scripts/install-into-target-repo.sh"
  "scripts/codex-interview-plan.sh"
  "scripts/codex-demo.sh"
  "scripts/codex-agent-board-review.sh"
  "scripts/pre-push-check.sh"
  "scripts/hackathon-bootstrap.sh"
  "scripts/install-session-handoff.sh"
  "scripts/public-safety-scan.sh"
  "scripts/codex-retro.sh"
  "sample_data/site_candidates.csv"
)

for path in "${required[@]}"; do
  if [[ ! -f "$ROOT/$path" ]]; then
    echo "Missing required file: $path" >&2
    exit 1
  fi
done

bash -n "$ROOT"/scripts/*.sh
echo "Smoke check passed."
