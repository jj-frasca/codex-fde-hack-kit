Run an adversarial agent-team audit before push or demo.

Use this as a production-readiness board. Every role should make the architecture and workflow more defensible, not merely list preferences.

Use these roles:

- Problem Framer
- Architecture Mapper
- Product/Demo
- Reliability
- Security/Privacy
- DX/Setup
- Maintainability
- Red Team

Simulate the board sequentially and clearly label each role. Do not spawn subagents unless the user explicitly asks for a parallel review.

Inspect:

- current git status and diff
- README / AGENTS instructions
- tests, scripts, and smoke checks
- public-safety risks
- demo readiness
- scope and overbuild risk
- architecture tradeoffs and simpler alternatives
- whether one coherent artifact exists

If you are running in a read-only sandbox, do not execute checks that require temp-directory creation or writes. Inspect those scripts, report the environment limitation, and distinguish it from repo blockers. Treat separately supplied writable-shell check output as evidence when present.

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

Do not modify files. Findings should be concrete and tied to files, commands, or observable behavior.
