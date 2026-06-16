Run an adversarial agent-team review before push or demo.

Use the roles from `agent_team_board.md`:

- Problem Framer
- Product/Demo Reviewer
- Reliability Reviewer
- Security/Privacy Reviewer
- Maintainability Reviewer
- Red Team

If subagents are available, run roles in parallel. If subagents are not available, simulate the board sequentially and clearly label each role.

Review:

- current git status and diff
- README / AGENTS instructions
- tests, scripts, and smoke checks
- public-safety risks
- demo readiness
- scope and overbuild risk

Cap output to blockers plus at most one high-signal finding per role. For product/demo findings, include why it affects candidate speed or demo clarity.

Return:

```text
Executive verdict:
Blockers:
High-risk findings:
Medium/low findings:
Checks run:
Fix plan:
Ready to push/demo: yes / no
```

Do not modify files unless explicitly asked. Findings should be concrete and tied to files, commands, or observable behavior.
