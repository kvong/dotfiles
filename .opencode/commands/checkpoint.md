
---
description: Stage and commit the current checkpoint
agent: git-operator
subtask: true
---

Prepare a checkpoint commit for: $ARGUMENTS

Steps:
1. Review git status, diff, and the builder's validation status.
2. Group files by concern.
3. Stage only the files for the current checkpoint.
4. Propose a conventional commit message.
5. If validation status is missing or unclear, stop and ask for it before committing.
6. If the diff mixes concerns, do not commit blindly—explain the split needed.
7. Create the commit once the checkpoint is isolated.
8. Display the remaining checkpoint(s) if any.
