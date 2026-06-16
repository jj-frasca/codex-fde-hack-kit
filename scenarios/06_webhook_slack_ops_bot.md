# Slack/Webhook Ops Bot

- Domain: operational automation.
- Build prompt: Consume webhook events and produce concise Slack-ready alerts.
- Sample inputs: `sample_data/webhook_events.jsonl`.
- MVP requirements: parse JSONL, route by event type, format alert text, suppress low-value noise.
- Stretch goals: retry handling, dedupe, incident channel routing, slash command ack.
- Production-grade signals: idempotency, rate-limit awareness, no secrets in logs.
- Codex practice loop: build formatter, add fixture-based smoke check, document assumptions.

After completing this scenario: run tests, summarize the diff, write a demo note, run the retrospective prompt, and decide whether exactly one harness improvement should be promoted.
