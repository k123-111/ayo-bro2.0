Resume work from the latest Ayo handoff document.

Follow the same behavior as the `oya` command in the `ayo` skill:

1. Determine the current project directory.
2. Find Markdown handoff files in `ayo-handoffs/*.md`.
3. Read the latest handoff file by modified time, falling back to the newest timestamp in filenames like `handoff-YYYYMMDD-HHMMSS.md`.
4. Inspect additional project files only when needed to verify current state.
5. Reply with a short summary of:
   - The handoff file read.
   - Current goal.
   - Current progress.
   - Proposed next action.
6. Ask the user to confirm before executing any next task.
7. Do not modify files, run project-changing commands, start services, install dependencies, commit, push, or otherwise continue work until the user clearly confirms.

If no handoff file exists, explain that no `ayo-handoffs` Markdown file was found and ask the user to run `ayo` first or provide the handoff content.

