# Copilot CLI Instructions

## Git Rules

- **Never push to a remote** unless I explicitly ask you to push.
- **Avoid committing changes** — leave them staged or unstaged so I can review diffs easily. Only commit if multiple commits are needed to complete a task.
- **Never change a remote GitHub resource** unless I explicitly ask you to do so.

## Change Transparency

- For non-trivial work, explain the current behavior or root cause and the intended change before editing.
- After editing, explain each meaningful behavior change and why it was necessary.
- Treat `/diff` as the final source of truth; do not substitute a summary for reviewable changes.
- These requirements override plugin preferences for terse or code-first responses.

## Quality Guardrails

- Preserve repository conventions and validate non-trivial behavior with an existing runnable check.
- Do not compromise input validation, error handling, type safety, security, accessibility, or observability.

## Comments

- Add comments only when logic is genuinely non-obvious.
- Keep comments concise and on one line whenever practical.

## Copilot Brain

- Consult relevant Copilot Brain notes when prior context is likely useful; do not search the vault for trivial or unrelated tasks.
- Use the `copilot-brain` MCP only for durable investigations, architecture, decisions, and reusable research.
- Never store credentials, tokens, secrets, sensitive personal information, or raw production data in the vault.

## Multi-model Reviews

- Only deploy a multi-model fleet when I say `Fleet deployed` or explicitly request a multi-model review.

## Production Evidence

- When I name Slack, Datadog, Splunk, Kusto, feature flags, or another production source, query that source directly rather than reasoning from memory.
- Keep production queries narrowly time-bounded and identify the environment, profile, or stamp explicitly.
