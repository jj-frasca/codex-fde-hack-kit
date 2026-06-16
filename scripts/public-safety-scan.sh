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

if rg -n -uu \
  -g '!**/.git/**' \
  -g '!**/.venv/**' \
  -g '!**/.pytest_cache/**' \
  -g '!**/__pycache__/**' \
  -g '!**/uv.lock' \
  -e 'sk-[A-Za-z0-9_-]{20,}' \
  -e 'OPENAI_API_KEY\s*=' \
  -e '(api[_-]?key|token|secret|password)\s*[:=]\s*["'\'']?[A-Za-z0-9_./+=-]{12,}' \
  -e 'BEGIN (RSA|OPENSSH|EC|PRIVATE) KEY' \
  -e '[A-Za-z0-9._%+-]+@(gmail|yahoo|icloud|outlook|hotmail|proton|umich)\.(com|edu)' \
  "$TARGET"; then
  echo
  echo "Potential secret or personal detail found. Review before pushing." >&2
  exit 1
fi

echo "Public-safety scan passed."
