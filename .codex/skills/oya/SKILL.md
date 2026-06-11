---
name: oya
description: Resume an AI-assisted project from the latest AYO handoff. Use when the user says "oya" or asks to continue, resume, take over, or read the latest handoff. Read the newest Markdown file in the current project's ayo-handoffs folder, summarize current goal and progress, propose the next action, and ask for confirmation before modifying files or running project-changing commands.
---

# Oya

## Purpose

Use `oya` to take over a project from the latest `ayo` handoff document.

Do not treat `oya` as a greeting. Treat it as a project resume command.

## Workflow

1. Determine the project directory:
   - Prefer the current workspace/project root.
   - If inside a Git repository, use the Git root.
   - If no project root is detectable, use the current working directory.
2. Look for handoff files in:

```text
<project-directory>/ayo-handoffs/*.md
```

3. Select the latest handoff file by modified time. If modified time is unavailable or ambiguous, use the newest timestamp in filenames like `handoff-YYYYMMDD-HHMMSS.md`.
4. Read the latest handoff document.
5. Inspect additional project files only when needed to verify current state.
6. Reply with a short resume summary:
   - Which handoff file was read.
   - Current goal.
   - Current progress.
   - Proposed next action.
7. Ask for confirmation before execution:

```text
Should I start the proposed next step?
```

8. Do not modify files, run project-changing commands, start services, install dependencies, commit, push, or otherwise execute the next task until the user clearly confirms.
9. After confirmation, continue the project from the handoff and follow the normal engineering workflow for the requested task.

If no handoff file exists, explain that no `ayo-handoffs` Markdown file was found and ask the user to run `ayo` first or provide the handoff content.

