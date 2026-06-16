# Messy Partner Data Reconciliation

- Domain: partner operations and data quality.
- Build prompt: Reconcile inconsistent partner records and produce a review queue.
- Sample inputs: combine `site_candidates.csv` and hand-edited duplicate rows.
- MVP requirements: normalize names, detect likely duplicates, explain match reasons.
- Stretch goals: fuzzy matching, merge proposals, confidence scores.
- Production-grade signals: reversible merges, review-before-write, raw data preserved.
- Codex practice loop: inspect messy fields, start with deterministic normalization, verify examples.

After completing this scenario: run tests, summarize the diff, write a demo note, run the retrospective prompt, and decide whether exactly one harness improvement should be promoted.
