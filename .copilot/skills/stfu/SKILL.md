---
name: stfu
description: Remove unnecessary comments from the current changes. Use only when the user explicitly invokes this skill or asks for a comment-cleanup pass.
user-invocable: true
---

# Prune comments

Review comments added or modified in the current diff and leave the code
readable to a developer who has none of the conversation context.

Default to the current staged and unstaged changes. Do not clean up unrelated
pre-existing comments unless the user explicitly broadens the scope.

## Establish the comment contract

Before deleting anything:

1. Read the applicable repository instructions.
2. Identify the languages and file types in the diff.
3. Inspect existing lint, formatter, compiler, documentation, test, and
   code-generation rules that may require or interpret comments.
4. Search nearby code or configuration when the meaning of a directive is
   uncertain.

Never assume a comment is inert. Preserve required or behavior-affecting
comments, including:

- Linter, formatter, type-checker, and compiler directives
- Build tags, pragmas, and feature markers
- Code-generation and generated-file markers
- Coverage exclusions and test-runner directives
- Public API documentation required by repository or language rules
- License headers and legally required notices
- Security, compatibility, migration, and operational warnings
- Intentional fallthrough, exhaustive-switch, or similar annotations

Do not remove an unfamiliar directive until its purpose has been verified.

## Apply the cold-reader test

Evaluate each changed comment as if a reviewer opened the diff without the
conversation that produced it.

Remove comments that:

- Restate names, types, assignments, or straightforward control flow
- Narrate what the next line or block visibly does
- Preserve an abandoned approach, agent disagreement, or implementation
  conversation that is not part of the current design
- Justify a choice only in relation to something proposed earlier in the chat
- Refer vaguely to "this approach", "the alternative", "for now", "we
  decided", or similar context a future reader cannot recover
- Describe behavior that the current code no longer has
- Add headings to short, self-explanatory blocks

Keep comments that communicate durable information unavailable from the code:

- Why the obvious implementation is intentionally not used
- A non-obvious invariant, constraint, or external-system requirement
- A surprising edge case or safety boundary
- A deliberate tradeoff that future maintainers need when changing the code

When a comment contains durable rationale but depends on conversation context,
rewrite it to name the actual constraint directly. Do not preserve the history
of the discussion.

For example:

```text
Remove:
// We decided not to cache this because of the race Andrew mentioned.

Rewrite:
// Re-read on each request because cached permissions can outlive revocation.
```

If the rationale belongs in the pull request, commit message, decision record,
or documentation rather than beside the code, remove it from the code. Do not
move it elsewhere unless the user asks.

## Make the cleanup

- Read enough surrounding code to judge each comment in context.
- Delete comments with no durable value.
- Tighten comments that are useful but verbose or conversation-dependent.
- Do not change executable behavior while performing this pass.
- Do not use regex or bulk deletion.
- Do not add replacement comments merely to preserve comment density.

Review the resulting diff and confirm that every remaining changed comment is
understandable cold, accurate, and either required or meaningfully explanatory.
Run an existing targeted lint or documentation check when comment removal may
affect a repository rule.

Report the categories of comments removed or rewritten and call out any
comments retained because a tool or repository rule requires them.
