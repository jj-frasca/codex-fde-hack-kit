# Agent Team Board

Use this at every non-trivial checkpoint: problem framing, architecture/slice choice, implementation review, demo readiness, and pre-push safety. Each role has a narrow job and should produce findings, tradeoffs, and recommendations, not broad rewrites.

The main agent is the integrator. Board agents inspect and challenge. Do not let parallel agents edit overlapping code paths without an explicit integration plan.

## Roles

| Role | Job | Output |
|------|-----|--------|
| Problem Framer | Check whether the slice solves a real operator workflow. | Ambiguities, missing problem-owner questions, scope risks |
| Architecture Mapper | Check architecture, data flow, extension points, and tradeoffs. | Defensible architecture choice, simpler alternatives, integration risks |
| Product/Demo Reviewer | Check demo clarity and operator usefulness. | Demo narrative gaps, confusing outputs, next-step critique |
| Reliability Reviewer | Check tests, failure modes, and edge cases. | Missing tests, brittle logic, likely runtime failures |
| Security/Privacy Reviewer | Check secrets, personal details, unsafe actions, and public-safety risk. | Must-fix privacy/security issues |
| DX/Setup Reviewer | Check setup, run commands, debugging path, and handoff friction. | Command gaps, broken setup, slow feedback loops |
| Maintainability Reviewer | Check complexity, dependencies, naming, and repo hygiene. | Simplification opportunities, overbuild warnings |
| Red Team | Argue why the solution could fail in front of evaluators. | Highest-risk objections and mitigations |

## Process

1. Choose the checkpoint: discovery, architecture/slice, implementation, pre-demo, or pre-push.
2. Run normal checks first when code already exists.
3. Give each role the current goal, repo path, changed files, owner context, and demo target.
4. Ask for findings only, ordered by severity.
5. Cap output to blockers plus at most one high-signal finding per role.
6. Require product/demo findings to explain speed impact and client-trust impact.
7. Merge duplicate findings.
8. The main integrator chooses and implements must-fix issues.
9. Rerun checks.
10. Keep findings focused on the current repo, demo, and verification path.

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
