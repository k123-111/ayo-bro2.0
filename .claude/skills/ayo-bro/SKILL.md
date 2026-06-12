---
name: ayo-bro
description: Create a game-like AYO project checkpoint. Use when the user says "ayo bro", asks to save progress, create a checkpoint, archive the current project state, or make a safe save point. Use Git to store code and .ayo/memory.md plus .ayo/checkpoints.json to store project memory. Keep only the latest AYO checkpoint record; each new checkpoint replaces the previous AYO save slot.
---

# Ayo Bro

## Purpose

Use `ayo bro` as a game-like save command.

Git stores what changed. AYO stores why it changed.

## Workflow

1. Determine the project directory:
   - Prefer the current workspace/project root.
   - If inside a Git repository, use the Git root.
   - If no project root is detectable, use the current working directory.
2. Check whether Git is available. If Git is not installed or cannot run, explain that checkpointing requires Git and stop.
3. If the project is not a Git repository, run `git init`.
4. If Git commit identity is missing, set repository-local defaults instead of stopping:

```text
git config user.name "AYO"
git config user.email "ayo@example.local"
```

5. Create `.ayo/` in the project root.
6. Write `.ayo/memory.md` as a fresh project memory summary. Do not copy README verbatim. Summarize:
   - Project name.
   - Project goal.
   - Current development progress.
   - Recent changes.
   - Core files.
   - Current problems.
   - Next plan.
   - Notes for a future AI.
7. Treat `.ayo/checkpoints.json` as an untracked single-slot save file. Ensure `.ayo/checkpoints.json` is ignored by Git by adding this line to `.git/info/exclude` if it is not already present:

```text
.ayo/checkpoints.json
```

8. If `.ayo/checkpoints.json` is already tracked, remove it from the Git index without deleting the working file:

```text
git rm --cached .ayo/checkpoints.json
```

9. Stage all project files except `.ayo/checkpoints.json`. Include `.ayo/memory.md`.
10. Create a checkpoint commit with message. If there are no staged changes, create an empty checkpoint commit with `git commit --allow-empty` so every `ayo bro` produces a restorable save point:

```text
AYO_CHECKPOINT_YYYYMMDD_HHMM
```

11. Get the checkpoint commit hash with `git rev-parse HEAD`.
12. Move or create the checkpoint tag so it points at this commit:

```text
git tag -f ayo-checkpoint <commit>
```

13. Overwrite `.ayo/checkpoints.json` with a JSON array containing only the latest checkpoint entry:

```json
[
  {
    "id": "checkpoint_latest",
    "commit": "abc123",
    "time": "2026-06-11 21:05",
    "summary": "Completed login module"
  }
]
```

14. Do not commit `.ayo/checkpoints.json`. It is local AYO metadata and must survive `git reset --hard`.
15. Reply with checkpoint id, commit hash, time, and summary.

Older Git commits may remain in Git history, but AYO should only reference the latest checkpoint through `.ayo/checkpoints.json` and the `ayo-checkpoint` tag.
