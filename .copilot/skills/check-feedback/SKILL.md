---
name: check-feedback
description: Fetch and evaluate review feedback for the pull request associated with the current branch. Use when the user asks to check PR feedback, review comments, requested changes, or unresolved conversations.
direct-model-invocation: true
---

# Check pull request feedback

1. Derive the repository, branch, and pull request from the current checkout.
2. Use `gh` or available GitHub tools to fetch reviews, inline comments,
   conversations, and relevant failed checks.
3. Read enough surrounding code and pull request context to evaluate each item.
4. Classify feedback as valid, invalid, already addressed, or needing
   clarification.
5. Explain the evidence and the smallest appropriate response for each item.

Return a concise assessment grouped by classification. Do not accept feedback
merely because a reviewer stated it, and do not dismiss it without checking the
larger codebase.

By default this skill is read-only. Do not edit code, reply to comments, resolve
threads, submit a review, commit, push, or otherwise mutate GitHub unless the
user explicitly requests that action.
