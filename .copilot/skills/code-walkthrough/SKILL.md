---
name: code-walkthrough
description: Explains existing code so the user can build a mental model. Use when the user asks how code works, where to look, or why something breaks, especially open-ended requests to verify their current understanding. Not for execution tasks, quick lookups, or communication artifacts intended for other people.
user-invocable: true
---

# Explaining code to a human

The reader is building a mental model, not consuming a report. Optimize for
uptake rather than coverage. A correct explanation that requires several
read-throughs has failed.

Lead with the conclusion in plain words, then make everything after it support
that one sentence. If the conclusion cannot be stated simply, keep reading the
code before writing.

Avoid dense dumps where every fact has equal weight, logic is compressed into
arrows, identifiers crowd each sentence, and the actual point arrives last.

## Explain the shape

- Open with the answer the reader would repeat to a coworker.
- Keep the actor in the sentence: say who does what to what.
- Spell out causal logic with words such as "so", "because", and "which means".
- Name only the two or three symbols that carry the central idea.
- Cite supporting code as `path/to/file:line` and explain what each referenced
  symbol does so the pointer is useful when opened by itself.
- Separate behavior verified in code from likely explanations and unanswered
  questions.

## Choose the right depth

- Start with the broad shape and widen only when the user asks.
- Ask which angle matters only when the request is genuinely vague.
- For a flow across three or more steps or components, lead with a small
  diagram of roughly four to seven nodes. Prefer ASCII in a terminal and
  Mermaid where it renders well.
- Provide an exhaustive trace when the user explicitly requests one.

## Before responding

- Put the takeaway in the first sentence.
- Make the first short paragraph sufficient to understand the gist.
- Replace compressed arrows and comma chains with explicit causal language.
- Remove identifiers the reader does not need yet.
- Present the explanation as a coherent story rather than a stack trace.

## Example

Too dense:

> Code Coverage is `IsThirdPartyApp()==false` -> `useCopilotAppForAuth==false`
> -> authenticates as its own integration; Launch exact-matches `baseConfig`,
> no entry -> `NotFound`; the monolith only forwards Launch's message on 422,
> so the 404 becomes `500 Failed to run dynamic workflow`.

Better:

> **Short version:** a 404 inside Launch gets flattened into a generic 500
> before it reaches the caller.
>
> Launch keeps an allowlist of valid workflow paths. This app's path is absent,
> so Launch rejects the call as not found. The monolith only preserves Launch's
> error message for a 422 response; every other status becomes "500 Failed to
> run dynamic workflow". That is why the caller cannot see the actual problem:
> an unregistered workflow path.
>
> Start at `actions.go:146`, where `useCopilotAppForAuth` determines the path
> format. Then inspect `baseConfig`, the allowlist that Launch checks before
> accepting that path.
