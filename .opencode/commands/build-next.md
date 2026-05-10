
---
description: Implement the next checkpoint
agent: builder
subtask: true
---

Implement the next checkpoint for: $ARGUMENTS

Rules:
1. Follow the latest architect plan, including the checkpoint's test expectation.
2. Keep the change as small and reviewable as possible.
3. Run the planned simple test when practical, or give exact user steps to verify the checkpoint.
4. Make validation status explicit before any commit handoff.
5. Stop at a clean checkpoint.
6. Summarize changed files and reasoning.
7. State whether docs are now stale.
8. Hand off to @git-operator for staging and commit only after validation status is clear.
