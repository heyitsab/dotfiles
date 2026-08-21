---
name: production-proof
description: Investigate incidents or verify production claims with direct evidence from sources such as Slack, Splunk, Datadog, Kusto, and feature flags. Use when the user asks what happened in production, whether a fix worked, or requests evidence across named production systems.
user-invocable: true
---

# Prove production claims

Turn the user's question into explicit claims and identify the evidence needed
to support or reject each one. Query only the systems relevant to those claims.

## Investigation rules

- Use a named production source directly rather than reasoning from memory.
- Keep every query narrowly time-bounded.
- Identify the environment, region, profile, or stamp in the query and report.
- Prefer aggregate queries to establish scope, then inspect a small number of
  representative raw events.
- Correlate systems using stable identifiers such as request, trace, task,
  repository, deployment, or user IDs.
- For Splunk, invoke the specific operational tool needed rather than using a
  meta-tool to infer capabilities.
- Treat Slack as operational context, not proof of system behavior.
- Do not copy raw production data into Copilot Brain.

Do not silently broaden the time window, environment, or population when a
query returns no results. Explain the gap and choose the next query
deliberately.

## Report

Lead with the answer supported by the evidence, then provide:

| Claim | Evidence | Source and window | Confidence | Gap |
| --- | --- | --- | --- | --- |

Clearly distinguish:

- **Observed:** directly present in the queried source.
- **Inferred:** the most likely explanation connecting observations.
- **Unknown:** evidence that is missing or unavailable.

Do not call an incident resolved or a fix verified unless the observed evidence
covers the relevant failure mode and post-change window.
