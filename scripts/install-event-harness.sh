#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
AGENTS_HOME="$HOME/.agents"
STAMP="$(date +%Y%m%d%H%M%S)"

backup_if_exists() {
  local path="$1"
  if [[ -e "$path" || -L "$path" ]]; then
    local backup="$path.bak.$STAMP"
    mv "$path" "$backup"
    echo "Backed up existing $path to $backup"
  fi
}

mkdir -p "$CODEX_HOME" "$CODEX_HOME/agents" "$CODEX_HOME/skills" "$AGENTS_HOME/skills"

if [[ ! -f "$CODEX_HOME/AGENTS.md" ]]; then
  cp "$ROOT/AGENTS.global.md" "$CODEX_HOME/AGENTS.md"
  echo "Installed global Codex AGENTS.md"
else
  echo "Global Codex AGENTS.md already exists: $CODEX_HOME/AGENTS.md"
fi

backup_if_exists "$AGENTS_HOME/skills/repo-deep-dive"
cp -R "$ROOT/.agents/skills/repo-deep-dive" "$AGENTS_HOME/skills/repo-deep-dive"
echo "Installed repo-deep-dive skill to $AGENTS_HOME/skills/repo-deep-dive"

backup_if_exists "$CODEX_HOME/skills/repo-deep-dive"
cp -R "$ROOT/.agents/skills/repo-deep-dive" "$CODEX_HOME/skills/repo-deep-dive"
echo "Installed repo-deep-dive skill to $CODEX_HOME/skills/repo-deep-dive"

cp "$ROOT/.codex/agents/"*.toml "$CODEX_HOME/agents/"
echo "Installed custom read-only agents to $CODEX_HOME/agents"

if [[ ! -f "$CODEX_HOME/onsite-safe.config.toml" ]]; then
  cat >"$CODEX_HOME/onsite-safe.config.toml" <<'TOML'
sandbox_mode = "workspace-write"
approval_policy = "on-request"
model_reasoning_effort = "medium"

[features]
hooks = true
goals = true
multi_agent = true

[shell_environment_policy]
inherit = "core"
ignore_default_excludes = false
exclude = [
  "*_TOKEN",
  "*_SECRET",
  "*_KEY",
  "AWS_*",
  "AZURE_*",
  "GOOGLE_*",
  "GITHUB_TOKEN",
  "OPENAI_API_KEY",
]
TOML
  echo "Installed onsite-safe Codex profile"
else
  echo "onsite-safe profile already exists: $CODEX_HOME/onsite-safe.config.toml"
fi

echo
echo "Event harness installed."
echo
echo "Day-of use:"
echo "  cd /path/to/challenge-repo"
echo "  codex --profile onsite-safe"
echo
echo "Then ask:"
echo '  Use $repo-deep-dive with a specialist board. Inspect this repo deeply, explain the architecture, find flaws, and recommend the best one-day hackathon slice.'
echo
echo "If skill discovery is stale, restart Codex or reference:"
echo "  $CODEX_HOME/skills/repo-deep-dive/SKILL.md"
