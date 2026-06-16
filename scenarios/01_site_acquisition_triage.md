# Site Acquisition Triage Tool

- Domain: expansion, real estate, operations.
- Build prompt: Build a tool that ranks candidate sites from CSV data and explains the reason codes.
- Sample inputs: `sample_data/site_candidates.csv`.
- MVP requirements: parse CSV, score candidates, flag blockers, print top sites with reasons.
- Stretch goals: map view, reviewer notes, scenario weights, exportable short list.
- Production-grade signals: auditable scoring, missing-data handling, configurable thresholds, no black-box final decisions.
- Codex practice loop: inspect data, build CLI/table first, add one smoke check, summarize diff.

After completing this scenario: run tests, summarize the diff, write a demo note, run the retrospective prompt, and decide whether exactly one harness improvement should be promoted.
