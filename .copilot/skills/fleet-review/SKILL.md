---
name: fleet-review
description: Run and synthesize a focused multi-model review. Use only when the user says "Fleet deployed" or explicitly requests a multi-model review.
user-invocable: true
---

# Focused fleet review

Use a fleet only for a consequential review or decision where independent
reasoning is worth the additional cost.

## Review setup

1. Select four strong models from meaningfully different model families.
2. Give every reviewer the same artifact, context, constraints, review
   questions, and requested output format.
3. Keep reviews independent until all reviewers have responded.
4. Ask for concrete evidence and actionable findings, not general impressions.

Do not divide reviewers into different scopes when the goal is independent
agreement about the same artifact.

## Verify and synthesize

Verify actionable claims against the code, diff, or source data before treating
them as findings. Agreement prioritizes investigation; it does not prove that a
claim is correct.

Produce a consensus map with:

| Field | Meaning |
| --- | --- |
| Finding | The concrete issue or recommendation |
| Reviewers | Which models independently raised it |
| Severity | Impact if the finding is correct |
| Evidence | Verified code or data supporting it |
| Disagreement | Material differences between reviewers |
| Action | Recommended next step |

Separate verified findings, plausible concerns needing follow-up, and rejected
claims. Preserve useful minority findings when the evidence supports them.
