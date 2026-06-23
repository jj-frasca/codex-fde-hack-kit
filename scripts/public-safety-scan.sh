#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-.}"

if [[ ! -d "$TARGET" ]]; then
  echo "Usage: $0 /path/to/repo-or-folder" >&2
  exit 2
fi

if ! command -v rg >/dev/null 2>&1; then
  echo "ripgrep (rg) is required for public-safety-scan.sh." >&2
  exit 1
fi

common_args=(
  -n -uu --no-heading
  -g '!**/.git/**' \
  -g '!**/.venv/**' \
  -g '!**/.pytest_cache/**' \
  -g '!**/__pycache__/**' \
  -g '!**/uv.lock' \
)

found=0

scan_pattern() {
  local label="$1"
  local pattern="$2"
  local matches
  matches="$(rg "${common_args[@]}" -e "$pattern" "$TARGET" || true)"
  if [[ -n "$matches" ]]; then
    found=1
    printf '%s\n' "$matches" | awk -F: -v label="$label" '{print $1 ":" $2 ": potential " label}'
  fi
}

scan_pattern "OpenAI API key" 'sk-[A-Za-z0-9_-]{20,}'
scan_pattern "OPENAI_API_KEY assignment" 'OPENAI_API_KEY\s*='
scan_pattern "credential-like assignment" '(api[_-]?key|token|secret|password)\s*[:=]\s*["'\'']?[A-Za-z0-9_./+=-]{12,}'
scan_pattern "private key" 'BEGIN (RSA|OPENSSH|EC|PRIVATE) KEY'
scan_pattern "personal email" '[A-Za-z0-9._%+-]+@(gmail|yahoo|icloud|outlook|hotmail|proton|umich)\.(com|edu)'
scan_pattern "local user path" '/Users/[A-Za-z0-9._-]+'

scan_private_marker() {
  local label="$1"
  local pattern="$2"
  local matches
  matches="$(rg "${common_args[@]}" -e "$pattern" "$TARGET" || true)"
  if [[ -n "$matches" ]]; then
    matches="$(printf '%s\n' "$matches" | awk -F: '
      $1 ~ /(^|\/)scripts\/public-safety-scan\.sh$/ { next }
      $1 ~ /(^|\/)scripts\/init-private-context\.sh$/ { next }
      $1 ~ /(^|\/)docs\/private_context_workflow\.md$/ { next }
      $1 ~ /(^|\/)prompts\/15_private_context_guard\.md$/ { next }
      { print }
    ')"
  fi
  if [[ -n "$matches" ]]; then
    found=1
    printf '%s\n' "$matches" | awk -F: -v label="$label" '{print $1 ":" $2 ": potential " label}'
  fi
}

scan_private_marker "private-context marker" 'PRIVATE_CONTEXT'
scan_private_marker "NDA marker" 'NDA'
scan_private_marker "do-not-commit marker" 'do not commit'
scan_private_marker "confidential marker" 'confidential'

if [[ "$found" -ne 0 ]]; then
  echo
  echo "Potential secret or personal detail found. Review paths before pushing." >&2
  exit 1
fi

echo "Public-safety scan passed."
