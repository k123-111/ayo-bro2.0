Restore the latest AYO project checkpoint.

Follow the same behavior as the `fuck` command in the `ayo` skill:

1. Read `.ayo/checkpoints.json` in the current project.
2. Find the only checkpoint entry. If an older multi-entry index exists, use the last entry as a fallback.
3. Show the checkpoint id, commit hash, time, and summary.
4. Ask the user to confirm before restoring.
5. Do not run `git reset --hard` until the user clearly confirms.

After confirmation:

1. Verify the project is a Git repository.
2. Prefer the `ayo-checkpoint` tag as the restore target when it exists. Otherwise use the commit recorded in `.ayo/checkpoints.json`.
3. Verify the restore target exists.
4. Preserve current uncommitted work with `git stash push -u -m AYO_BACKUP_BEFORE_RESTORE_YYYYMMDD_HHMM` when needed.
5. Restore with `git reset --hard <target>`.
6. Reply with the restored checkpoint details and whether a stash backup was created.

If `.ayo/checkpoints.json` is missing, empty, invalid, or the restore target is missing, explain the problem and do not reset.
