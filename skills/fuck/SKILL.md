---
name: fuck
description: Restore the latest AYO project checkpoint. Use when the user says "fuck" or asks to roll back, restore, load the last save, return to the last safe state, or undo project changes using the latest AYO checkpoint. Read .ayo/checkpoints.json, show the latest checkpoint, ask for confirmation, preserve current uncommitted work with a Git stash when needed, then restore with Git only after confirmation.
---

# Fuck

## Purpose

Use `fuck` as a game-like load command. It restores the latest `ayo bro` checkpoint.

Because rollback changes project files, ask for confirmation before executing any restore.

## Workflow

1. Determine the project directory:
   - Prefer the current workspace/project root.
   - If inside a Git repository, use the Git root.
   - If no project root is detectable, use the current working directory.
2. Verify the project is a Git repository.
3. Read `.ayo/checkpoints.json`.
4. Find the only checkpoint entry. If an older multi-entry index exists, use the last entry as a backward-compatible fallback.
5. Show:
   - checkpoint id
   - commit hash
   - time
   - summary
6. Ask for confirmation:

```text
Restore this checkpoint now?
```

7. Do not run `git reset --hard` until the user clearly confirms.
8. After confirmation, verify the checkpoint commit exists:

```text
git cat-file -e <commit>^{commit}
```

9. Preserve current uncommitted work when needed:

```text
git stash push -u -m AYO_BACKUP_BEFORE_RESTORE_YYYYMMDD_HHMM
```

If there is nothing to stash, continue.

10. Restore the project:

```text
git reset --hard <commit>
```

11. Reply with:
   - Restored checkpoint id.
   - Checkpoint time.
   - Checkpoint summary.
   - Restored commit hash.
   - Whether a pre-restore stash backup was created.

If `.ayo/checkpoints.json` is missing, empty, invalid JSON, or points to a missing commit, explain the problem and do not reset.

