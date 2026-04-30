# `docs-sync`

## Purpose

Keep README and other user-facing documentation aligned with implementation changes and workflow updates.

## When to use it

- After a code or config checkpoint changes behavior
- When commands, environment variables, setup steps, or workflow docs drift from reality
- When a builder flags docs as stale

## Required inputs

- Summary of the implementation change
- Relevant code, config, or command diffs
- Known documentation targets if already identified

## Primary agent/tool dependencies

- Primary agent: `docs-writer`
- Supporting references: `README.md`, `AGENTS.md`, `commands/*.md`, affected source/config files
- Optional coordination: builder summary of what changed

## Workflow steps

1. Review the implementation change and intended user-visible impact.
2. Identify which docs are now stale.
3. Update the minimum necessary docs for accuracy and discoverability.
4. Add migration or usage notes when behavior changed.
5. Summarize what was updated and any remaining gaps.

## Safety constraints

- Do not change source code
- Avoid speculative docs for behavior that is not implemented
- Keep updates scoped to the checkpoint instead of broad rewrites

## Output contract

- List of docs updated
- Concise summary of user-visible documentation changes
- Explicit note if any docs remain stale

## Example prompts

- "Use `docs-sync` to update README after adding a new command file."
- "Use `docs-sync` to sync setup docs for a changed environment variable."
