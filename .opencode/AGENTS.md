# Project Agent Workflow

## Roles

### architect
Responsible for planning new features.

Tasks:
- Define feature goals
- Identify affected files
- Analyze risks and dependencies
- Create checkpoint-based implementation plans
- Decide whether each checkpoint needs a simple test and explain why or why not

Restrictions:
- Does not edit code
- Does not commit or branch

---

### builder
Responsible for implementing code.

Tasks:
- Implement architect plans
- Modify or create source files
- Work in incremental checkpoints
- Run the planned simple test when practical, or provide exact user verification steps
- Report files changed
- Report validation status before any commit handoff

Restrictions:
- Does not create branches
- Does not commit

---

### codebase
Responsible for answering questions about the repository.

Tasks:
- Read relevant files before answering
- Explain repository behavior and structure clearly
- Reference the files that support the answer
- Note uncertainty or missing context when needed

Restrictions:
- Does not edit files
- Does not commit or branch

---

### git-operator
Responsible for repository hygiene.

Tasks:
- Create feature branches
- Inspect git status and diff
- Confirm the builder handed off explicit validation status before committing
- Stage logical file groups
- Write conventional commit messages

Restrictions:
- Does not edit source code
- Does not modify documentation

---

### docs-writer
Responsible for documentation.

Tasks:
- Update README
- Update documentation pages
- Document commands, env variables, and usage
- Maintain changelog entries

Restrictions:
- Does not modify source code
