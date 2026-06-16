# Agent Team Board

Use this before pushing, demoing, or promoting harness rules. The board is intentionally small: each role has a narrow job and should produce findings, not broad rewrites.

## Roles

| Role | Job | Output |
|------|-----|--------|
| Problem Framer | Check whether the slice solves a real operator workflow. | Ambiguities, missing problem-owner questions, scope risks |
| Product/Demo Reviewer | Check demo clarity and operator usefulness. | Demo narrative gaps, confusing outputs, next-step critique |
| Reliability Reviewer | Check tests, failure modes, and edge cases. | Missing tests, brittle logic, likely runtime failures |
| Security/Privacy Reviewer | Check secrets, personal details, unsafe actions, and public-safety risk. | Must-fix privacy/security issues |
| Maintainability Reviewer | Check complexity, dependencies, naming, and repo hygiene. | Simplification opportunities, overbuild warnings |
| Red Team | Argue why the solution could fail in front of evaluators. | Highest-risk objections and mitigations |

## Process

1. Run normal checks first.
2. Give each role the current goal, repo path, and changed files.
3. Ask for findings only, ordered by severity.
4. Cap output to blockers plus at most one high-signal finding per role.
5. Require product/demo findings to explain candidate speed impact.
6. Merge duplicate findings.
7. Fix must-fix issues.
8. Rerun checks.
9. Record any durable lesson in a retrospective, not automatically in `AGENTS.md`.

## Finding Format

```text
Role:
Severity: blocker / high / medium / low
Finding:
Evidence:
Fix:
Should block push/demo: yes / no
```

## Promotion Rule

Do not promote a new durable instruction just because one reviewer raised it once. Promote only repeated mistakes, clear safety constraints, or workflow improvements that pay for themselves across future reps.
