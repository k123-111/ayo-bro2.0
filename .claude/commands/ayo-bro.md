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
5. Create or update `.ayo/checkpoints.json` as an untracked single-slot save file. Each new `ayo bro` replaces the previous AYO checkpoint record.
6. Add `.ayo/checkpoints.json` to `.git/info/exclude` if it is not already present.
7. If `.ayo/checkpoints.json` is tracked, run `git rm --cached .ayo/checkpoints.json` without deleting the working file.
8. Stage project files except `.ayo/checkpoints.json`, including `.ayo/memory.md`.
9. Commit a safe project-state checkpoint with message `AYO_CHECKPOINT_YYYYMMDD_HHMM`. If there are no staged changes, use `git commit --allow-empty` so every `/ayo-bro` produces a restorable save point.
10. Read the checkpoint commit hash with `git rev-parse HEAD`.
11. Move or create the tag with `git tag -f ayo-checkpoint <commit>`.
12. Overwrite `.ayo/checkpoints.json` with one array entry using id `checkpoint_latest`, plus the checkpoint commit hash, time, and summary.
13. Do not commit `.ayo/checkpoints.json`.
14. Reply with checkpoint id, commit hash, time, and summary.

Git stores the code. AYO stores the memory. Older Git commits may remain in Git history, but AYO should only reference the latest checkpoint through `.ayo/checkpoints.json` and the `ayo-checkpoint` tag.
