# Evaluator Walkup Answers

Keep a 20-40 second answer ready during the build. Speak in workflow terms first, then technical terms only as needed.

## What Are You Building?

We are building a small tool that takes the messy inputs the owner already has and turns them into a reviewed output they can act on today. The goal is not a full platform; it is one trustworthy workflow from input to decision.

## Why This Artifact?

This artifact fits the actual bottleneck. It is small enough to finish, easy for the owner to inspect, and gives us a concrete demo of how the workflow changes.

## Why This Scope?

The scope protects usefulness. We chose one user, one decision, and one output so we can validate it instead of building a broad surface that only looks complete.

## What Changed After Owner Feedback?

The owner clarified which input is trusted, what output they would use in a meeting, and what must remain human-reviewed. That changed the artifact from a broad automation idea into a narrower decision aid.

## What Did Codex Do?

Codex helped inspect the repo, map the architecture, draft the plan, implement the narrow slice, and review risks. I kept the scope, trust boundaries, and final tradeoffs under human control.

## What Did You Decide Yourself?

I chose the artifact, non-goals, human-review boundary, and validation path. I also decided which Codex suggestions to reject because they were too broad for the timebox.

## How Are You Validating This?

I am using focused tests or smoke checks, sample messy inputs, source references or reason codes, and a manual review path with the problem owner.

## Biggest Risks?

The biggest risks are stale or untrusted inputs, overclaiming automation, and missing a workflow edge case. I am mitigating those with provenance, explicit limits, and human review.

## What Are You Not Building?

I am not building a full command center, autonomous approval system, or broad integration layer. Those are later steps after the useful slice is validated.

## One More Day?

I would add more source coverage, owner feedback loops, edge-case tests, and a cleaner handoff path into the team’s existing workflow.

## Demo Path?

I will show the owner pain, the messy input, the tool run, the useful output, why it can be trusted, where a human stays in control, and what I would productionize next.
