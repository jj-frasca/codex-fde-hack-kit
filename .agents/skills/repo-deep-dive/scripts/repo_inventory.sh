#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-.}"

if [[ ! -d "$TARGET" ]]; then
  echo "Usage: $0 /path/to/repo-or-folder" >&2
  exit 2
fi

if ! command -v rg >/dev/null 2>&1; then
  echo "ripgrep (rg) is required for repo inventory." >&2
  exit 1
fi

cd "$TARGET"

section() {
  printf '\n## %s\n' "$1"
}

section "Repo"
printf 'path: %s\n' "$(pwd)"
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  printf 'git_root: %s\n' "$(git rev-parse --show-toplevel)"
  printf 'branch: %s\n' "$(git branch --show-current 2>/dev/null || true)"
  printf 'head: %s\n' "$(git rev-parse --short HEAD 2>/dev/null || true)"
  section "Git Status"
  git status --short
else
  printf 'git_root: unavailable\n'
fi

section "Top-Level Files"
find . -maxdepth 2 \
  -path './.git' -prune -o \
  -path './node_modules' -prune -o \
  -path './.venv' -prune -o \
  -path './.pytest_cache' -prune -o \
  -path './.ruff_cache' -prune -o \
  -path './__pycache__' -prune -o \
  -name '*.pyc' -prune -o \
  -type f -print | sed 's#^\./##' | sort | sed -n '1,220p'

section "Instruction And Docs"
rg --files -g 'AGENTS.md' -g 'AGENTS.override.md' -g 'CLAUDE.md' -g 'README*' -g 'docs/**' -g '*.md' \
  -g '!**/.git/**' -g '!**/node_modules/**' -g '!**/.venv/**' -g '!**/.pytest_cache/**' -g '!**/.ruff_cache/**' \
  | sort | sed -n '1,180p' || true

section "Manifests And Config"
rg --files \
  -g 'package.json' -g 'pnpm-lock.yaml' -g 'yarn.lock' -g 'package-lock.json' \
  -g 'pyproject.toml' -g 'uv.lock' -g 'requirements*.txt' -g 'setup.py' -g 'poetry.lock' \
  -g 'Cargo.toml' -g 'go.mod' -g 'Gemfile' -g 'composer.json' \
  -g 'Dockerfile' -g 'docker-compose*.yml' -g 'Makefile' -g 'justfile' \
  -g '.github/workflows/**' -g '.gitlab-ci.yml' -g 'tox.ini' -g 'pytest.ini' \
  -g '!**/.git/**' -g '!**/node_modules/**' -g '!**/.venv/**' -g '!**/.pytest_cache/**' -g '!**/.ruff_cache/**' \
  | sort | sed -n '1,220p' || true

section "Likely Entrypoints"
rg -n \
  -e 'if __name__ == .__main__.' \
  -e 'def main\(' \
  -e 'app = FastAPI|Flask\(|express\(|createServer\(' \
  -e 'ReactDOM\.createRoot|createRoot\(' \
  -e 'click\.command|typer\.Typer|argparse\.ArgumentParser' \
  -e 'func main\(' \
  -e 'public static void main' \
  -g '!**/.git/**' -g '!**/node_modules/**' -g '!**/.venv/**' -g '!**/.pytest_cache/**' -g '!**/.ruff_cache/**' -g '!**/dist/**' -g '!**/build/**' \
  . | sed -n '1,220p' || true

section "Tests"
rg --files \
  -g 'test_*' -g '*_test.*' -g '*.test.*' -g '*.spec.*' -g 'tests/**' -g '__tests__/**' \
  -g '!**/.git/**' -g '!**/node_modules/**' -g '!**/.venv/**' -g '!**/.pytest_cache/**' -g '!**/.ruff_cache/**' -g '!**/__pycache__/**' -g '!**/*.pyc' \
  | sort | sed -n '1,220p' || true

section "Routes And APIs"
rg -n \
  -e '@app\.(get|post|put|patch|delete)' \
  -e 'APIRouter\(' \
  -e 'router\.(get|post|put|patch|delete)' \
  -e 'app\.(get|post|put|patch|delete)\(' \
  -e 'fetch\(|axios\.|requests\.' \
  -g '!**/.git/**' -g '!**/node_modules/**' -g '!**/.venv/**' -g '!**/.pytest_cache/**' -g '!**/.ruff_cache/**' -g '!**/dist/**' -g '!**/build/**' \
  . | sed -n '1,220p' || true

section "Data And Env"
rg --files \
  -g 'data/**' -g 'fixtures/**' -g 'sample*' -g 'examples/**' \
  -g '.env.example' -g '.env.sample' -g '*.env.example' -g '*.env.sample' \
  -g '!**/.git/**' -g '!**/node_modules/**' -g '!**/.venv/**' -g '!**/.pytest_cache/**' -g '!**/.ruff_cache/**' \
  | sort | sed -n '1,220p' || true

section "TODOs And Risk Markers"
rg -n \
  -e 'TODO|FIXME|HACK|XXX|not implemented|stub|mock|temporary|hardcoded|unsafe|insecure|debug' \
  -g '!**/.git/**' -g '!**/node_modules/**' -g '!**/.venv/**' -g '!**/.pytest_cache/**' -g '!**/.ruff_cache/**' -g '!**/dist/**' -g '!**/build/**' \
  . | sed -n '1,220p' || true

section "Suspicious Secret-Like Patterns"
scan_secret_pattern() {
  local label="$1"
  local pattern="$2"
  local matches
  matches="$(rg -n --no-heading \
    -e "$pattern" \
    -g '!**/.git/**' -g '!**/node_modules/**' -g '!**/.venv/**' -g '!**/.pytest_cache/**' -g '!**/.ruff_cache/**' -g '!**/dist/**' -g '!**/build/**' \
    . || true)"
  if [[ -n "$matches" ]]; then
    printf '%s\n' "$matches" | awk -F: -v label="$label" '{print $1 ":" $2 ": potential " label}'
  fi
}
scan_secret_pattern "OpenAI API key" 'sk-[A-Za-z0-9_-]{20,}'
scan_secret_pattern "OPENAI_API_KEY assignment" 'OPENAI_API_KEY\s*='
scan_secret_pattern "credential-like assignment" '(api[_-]?key|token|secret|password)\s*[:=]\s*["'\'']?[A-Za-z0-9_./+=-]{12,}'
scan_secret_pattern "private key" 'BEGIN (RSA|OPENSSH|EC|PRIVATE) KEY'

section "Likely Commands From Manifests"
for file in package.json pyproject.toml Makefile justfile; do
  if [[ -f "$file" ]]; then
    printf '\n### %s\n' "$file"
    sed -n '1,180p' "$file"
  fi
done
