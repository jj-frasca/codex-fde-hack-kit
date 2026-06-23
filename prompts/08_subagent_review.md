Run a specialist board review of the current branch.

Use subagents only if I explicitly ask for parallel agents. Otherwise simulate these roles sequentially:

- Architecture Mapper
- Product/Demo Reviewer
- Reliability Reviewer
- Security/Privacy Reviewer
- DX/Setup Reviewer
- Maintainability Reviewer
- Red Team

Prioritize bugs, regressions, missing validation, confusing workflow gaps, unsafe assumptions, architecture tradeoffs, and demo trust risks.

Return findings first, ordered by severity, with file and line references when possible. Do not modify files.
