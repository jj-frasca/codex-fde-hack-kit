# Board-Driven Execution

Use a specialist board for every non-trivial workflow decision, architecture choice, implementation review, and demo readiness check.

The main agent owns integration. Board roles inspect, challenge, and summarize. Avoid parallel agents editing the same code unless the work is deliberately split into isolated files with an explicit integration checkpoint.

## Board Checkpoints

1. Discovery board: clarify user, workflow, pain, trusted inputs, useful output, constraints, failure modes, and non-goals.
2. Architecture/slice board: choose one smallest useful artifact and defend why alternatives are worse for demo time.
3. Implementation board: keep one main integrator, one verification lane, one scope guard, and early integration.
4. Pre-demo board: review client trust, non-coder clarity, guardrails, limitations, and the production path.
5. Pre-push board: run safety scan, smoke checks, and adversarial review.

## Default Roles

- Problem Framer: protects the real workflow and owner need.
- Architecture Mapper: explains system shape, boundaries, and tradeoffs.
- Product/Slice Finder: chooses the smallest useful artifact.
- Reliability Reviewer: checks tests, failure modes, and edge cases.
- Security/Privacy Reviewer: checks secrets, private data, unsafe automation, and approval gates.
- DX/Setup Reviewer: checks install, run, verify, and handoff friction.
- Maintainability Reviewer: checks complexity, dependencies, naming, and repo hygiene.
- Red Team: argues why this could fail in front of the problem owner.

## Subagent Rules

- Use subagents for read-heavy exploration, risk review, test/log triage, and summarization.
- Keep subagent prompts narrow and require file references or observable evidence.
- Ask each subagent for findings, tradeoffs, and a concrete recommendation.
- Let the main agent merge duplicate findings and make the final call.
- Do not use subagents as theater. Each role must reduce risk, increase speed, or improve client trust.

## Decision Format

```text
Decision:
Options considered:
Recommendation:
Why this wins:
Tradeoffs:
Risks:
Validation:
Owner question:
```
