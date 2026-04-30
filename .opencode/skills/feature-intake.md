# `feature-intake`

## Purpose

Turn a rough feature request into a scoped implementation plan with risks, affected files, and reviewable checkpoints.

## When to use it

- When starting a new feature or enhancement
- When a request needs clarification before coding starts
- When the architect needs a consistent intake structure

## Required inputs

- Feature request or problem statement
- Goals, constraints, and non-goals if known
- Relevant repo area, files, or prior context when available

## Primary agent/tool dependencies

- Primary agent: `architect`
- Supporting references: `README.md`, `AGENTS.md`, `base.json`, `commands/feature.md`
- Optional tool use: repository reads and searches to ground the plan

## Workflow steps

1. Restate the request and target outcome.
2. Identify unclear requirements and assumptions.
3. Inspect the relevant parts of the repo.
4. List likely files, risks, test impact, and documentation impact.
5. Break the work into small checkpoints.
6. End with a builder-ready next checkpoint.

## Safety constraints

- Planning only; no code edits or commits
- Surface risky or ambiguous requirements before implementation begins
- Keep checkpoints small enough for isolated review and commit hygiene

## Output contract

- Goal summary
- Likely files to change
- Risks, dependencies, tests, and docs impact
- 3-7 checkpoint plan with a clear next step

## Example prompts

- "Use `feature-intake` to plan adding a new OpenCode command for release notes."
- "Use `feature-intake` to scope a cleanup of profile generation and identify migration risks."
