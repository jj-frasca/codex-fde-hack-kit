# Codex Operating Model

Strong prep treats Codex as an execution system, not a prompting surface.

The goal is reliable execution across a messy client problem: enough structure to preserve context, enough autonomy to move quickly, and enough verification that the client can trust the result.

A strong workflow:

1. Structure workspace.
2. Preserve context in brief files and `AGENTS.md`.
3. Create a shared repo context file for fresh sessions and agents.
4. Set persistent goals.
5. Define guardrails.
6. Use specialist boards for discovery, architecture/slice, implementation review, and demo trust.
7. Use Codex for repo triage.
8. Use Codex for implementation through one main integrator.
9. Use subagents/review threads for focused read-heavy review, test/log triage, and risk checks.
10. Verify outputs through tests, smoke runs, fixtures, or manual checklists.
11. Summarize diffs.
12. Convert output into a client-trust demo.

Anti-patterns:

- asking Codex for code with no context
- accepting code without tests
- building command centers for experts instead of small tools for clients
- hiding assumptions
- over-automating sensitive workflows
- failing to explain why outputs can be trusted

## Day-Of Operating Standard

- Keep a short working brief current: owner, pain, trusted inputs, output, constraints, next action.
- Keep `.codex-working/REPO_CONTEXT.md` current enough for fresh sessions to use.
- Use goals for multi-step work with clear completion criteria.
- Use subagents for bounded review lanes, not uncontrolled feature work.
- Keep one main integrator responsible for code edits; boards advise and pressure-test.
- Make guardrails visible: human approval, source evidence, dry runs, validation, and refusal cases.
- Treat every demo output as a client-facing trust artifact.
- Keep the working brief and active goal synchronized after every meaningful owner check-in.
- Close each build loop with evidence: a test, smoke run, sample case, source check, or explicit manual review.
- Use human-led planning for product and architecture decisions; Codex should surface options and tradeoffs, not silently choose the build direction.
