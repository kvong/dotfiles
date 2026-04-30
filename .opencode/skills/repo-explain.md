# `repo-explain`

## Purpose

Provide a grounded explanation of how this repository is structured, what key files do, and how the current workflow fits together.

## When to use it

- When a user asks how the repo works
- When onboarding a contributor to the scaffold
- When tracing which files define agent, command, profile, or config behavior

## Required inputs

- User question or topic to explain
- Relevant file paths or areas of interest when known

## Primary agent/tool dependencies

- Primary agent: `codebase`
- Tools: repository file reads, file search, content search
- Optional references: `README.md`, `AGENTS.md`, `base.json`, `commands/*.md`, `profiles/*.jsonc`

## Workflow steps

1. Clarify the scope of the explanation if the request is broad.
2. Read the most relevant source files before answering.
3. Summarize behavior in plain language.
4. Cite the supporting files.
5. Call out uncertainty, missing context, or inferred behavior.

## Safety constraints

- Read-only only
- Do not edit files, stage changes, or create commits
- Do not speculate about behavior when source files are available to verify it

## Output contract

- Short explanation of the requested area
- Bullet list of supporting files read
- Notes on assumptions or unresolved gaps, if any

## Example prompts

- "Use `repo-explain` to explain how profiles are merged into the generated config."
- "Use `repo-explain` to show how agent roles and command files work together in this repo."
