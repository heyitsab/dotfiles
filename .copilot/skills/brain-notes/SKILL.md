---
name: brain-notes
description: Research or preserve durable context in Copilot Brain. Use when the user asks to check prior decisions, follow related vault notes, remember something, save an investigation, or document substantial reusable work. Not for trivial task notes or temporary scratch work.
user-invocable: true
---

# Copilot Brain

Use the vault for durable understanding, not as a transcript or dumping ground.

## Research prior context

1. Search narrowly for the named system, decision, or project.
2. Read the most relevant note and follow only wikilinks needed to answer the
   current question.
3. Distinguish current documentation from historical context.
4. Name the notes used and explain when they materially affect the answer.

Do not search the vault for trivial or unrelated tasks.

## Save durable context

When the user asks to remember, save, or document substantial work:

1. Inspect the relevant folder and its `00 - Index` before choosing a path.
2. Create or update one focused note with a descriptive title.
3. Add YAML frontmatter and a small set of useful tags.
4. Link related concepts with `[[wikilinks]]`.
5. Record conclusions, evidence, uncertainty, and decisions rather than the
   full conversation.
6. Include provenance links to relevant repositories, pull requests, issues,
   sessions, or source documents.
7. Add the note to the appropriate index when it belongs to a knowledge base.

If the available Brain tools are read-only, return the proposed target path and
complete note content for review. State clearly that the note was not saved.

Never store credentials, tokens, secrets, sensitive personal information, or
raw production data.
