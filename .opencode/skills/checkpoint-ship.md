# `checkpoint-ship`

## Purpose

Prepare a clean implementation checkpoint for staging and commit by isolating the right file set and proposing a conventional message.

## When to use it

- After a builder or docs-writer checkpoint is complete
- When the diff needs to be reviewed and grouped before commit
- When a user wants commit hygiene without changing source files

## Required inputs

- Checkpoint summary or intended scope
- Current repository diff
- Any commit message constraints from the user or project

## Primary agent/tool dependencies

- Primary agent: `git-operator`
- Supporting references: `commands/checkpoint.md`, recent git history, current git status and diff
- Tools: git status, git diff, git log, staging, commit creation when explicitly requested

## Workflow steps

1. Review git status and both staged and unstaged changes.
2. Compare the diff against the intended checkpoint scope.
3. Separate unrelated work if the diff mixes concerns.
4. Stage only the relevant files.
5. Draft a conventional commit message focused on intent.
6. Create the commit only when the user asked for it.

## Safety constraints

- Do not edit source files
- Do not create branches unless explicitly requested elsewhere
- Do not commit unrelated files or likely secrets
- Do not create a commit unless the user explicitly asks for one

## Output contract

- File grouping or staging recommendation
- Proposed conventional commit message
- Clear note if the diff must be split before commit
- Post-commit status summary when a commit is actually created

## Example prompts

- "Use `checkpoint-ship` to review this checkpoint and propose a conventional commit message."
- "Use `checkpoint-ship` to stage only the skill-planning files and create the commit."
