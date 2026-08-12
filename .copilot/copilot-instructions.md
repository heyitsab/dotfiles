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

- Use the `copilot-brain` MCP for long-lived investigations, architecture context, decisions, and reusable research.
- Consult relevant vault notes when a task appears related to prior work; do not search the vault for trivial or unrelated tasks.
- When I explicitly ask to save, remember, or document substantial work, create or update a focused note in the appropriate vault folder.
- If the Brain is read-only, return the proposed note content and target path for review, and state clearly that it was not saved.
- Use YAML frontmatter, descriptive titles, tags, and `[[wikilinks]]` to connect related notes.
- Keep each knowledge base navigable through a `00 - Index` note rather than one large document.
- Include provenance links to relevant repositories, issues, pull requests, or session artifacts when available.
- Never store credentials, tokens, secrets, or sensitive personal information in the vault.

## Focused Fleet Reviews

- Only deploy a multi-model fleet when I say `Fleet deployed` or explicitly request a multi-model review.
- Use four strong, diverse models across model families rather than duplicating near-identical reviewers.
- Give each reviewer the same artifact, constraints, review questions, and requested output format.
- Keep reviews independent until synthesis.
- Synthesize findings into a consensus map showing which reviewers raised each issue, severity, evidence, disagreements, and recommended action.
- Treat agreement as a prioritization signal, not proof; verify actionable claims against code or data.

## Production Evidence Tools

- When a prompt names an MCP such as Slack, Datadog, Splunk, Kusto, or feature flags, use that source directly rather than reasoning from memory.
- For Splunk, load and invoke the specific tool needed, such as `list_profiles`, `health_check`, or `search_splunk`; do not use the server's `list_tools` meta-tool to infer availability.
- Keep production queries narrowly time-bounded and identify the profile or stamp explicitly.
