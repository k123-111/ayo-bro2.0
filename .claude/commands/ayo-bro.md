Create an AYO project checkpoint.

Follow the same behavior as the `ayo bro` command in the `ayo` skill:

1. Determine the current project directory.
2. If the project is not a Git repository, run `git init`.
3. If Git commit identity is missing, set repository-local defaults:
   - `git config user.name "AYO"`
   - `git config user.email "ayo@example.local"`
4. Create `.ayo/memory.md` with a fresh project memory summary:
   - Project name.
   - Project goal.
   - Current development progress.
   - Recent changes.
   - Core files.
   - Current problems.
   - Next plan.
   - Notes for a future AI.
5. Create or update `.ayo/checkpoints.json` as a single-slot save file. Each new `ayo bro` replaces the previous AYO checkpoint record.
6. Run `git add .`.
7. Commit a safe project-state checkpoint with message `AYO_CHECKPOINT_YYYYMMDD_HHMM`.
8. Read the checkpoint commit hash with `git rev-parse HEAD`.
9. Overwrite `.ayo/checkpoints.json` with one array entry using id `checkpoint_latest`, plus the checkpoint commit hash, time, and summary.
10. Commit the updated index with message `AYO_CHECKPOINT_INDEX_YYYYMMDD_HHMM`.
11. Reply with checkpoint id, commit hash, time, and summary.

Git stores the code. AYO stores the memory. Older Git commits may remain in Git history, but AYO should only reference the latest checkpoint.
