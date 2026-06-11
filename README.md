# ayo4.0.0

`ayo` is a chat-triggered AI skill for saving handoffs, resuming work, creating checkpoints, and restoring safe project states.

When you type `ayo` in an AI conversation, the skill asks the agent to read the visible chat context, inspect useful local project context when available, and save a handoff document to:

```text
<project-directory>/ayo-handoffs/handoff-YYYYMMDD-HHMMSS.md
```

The saved document includes:

- Project overview
- Current goal
- Progress so far
- Current state
- Project structure
- Important files and context
- Decisions made
- Open issues or blockers
- Next tasks
- A suggested next prompt

It is designed to work for any kind of project, not only Git repositories.

When the next person takes over, they can type `oya`. The AI reads the latest handoff in `ayo-handoffs`, summarizes the current state, proposes the next action, and asks for confirmation before continuing work.

For game-like project safety, type `ayo bro` to create a checkpoint and `fuck` to restore the latest checkpoint. AYO keeps one active checkpoint slot: running `ayo bro` again replaces the previous AYO checkpoint record and memory.

Product idea:

```text
Git stores what changed.
AYO stores why it changed.
```

## Repository Layout

```text
ayo4.0.0/
  skills/ayo/              # Canonical skill package
  skills/oya/              # Resume from latest handoff
  skills/ayo-bro/          # Create latest checkpoint
  skills/fuck/             # Restore latest checkpoint
  .claude/skills/ayo/      # Claude Code project-level copy
  .claude/skills/oya/
  .claude/skills/ayo-bro/
  .claude/skills/fuck/
  .claude/commands/ayo.md  # Claude Code slash command fallback
  .claude/commands/oya.md  # Claude Code resume command fallback
  .claude/commands/ayo-bro.md
  .claude/commands/fuck.md
  .codex/skills/ayo/       # Codex project-level copy for compatible environments
  .codex/skills/oya/
  .codex/skills/ayo-bro/
  .codex/skills/fuck/
  scripts/install.ps1      # Windows installer
  scripts/install.sh       # macOS/Linux installer
```

When the skill runs in a target project, it creates:

```text
ayo-handoffs/
  handoff-YYYYMMDD-HHMMSS.md
.ayo/
  memory.md
  checkpoints.json
```

## Claude Code

Clone this repository and open it with Claude Code. The project-level skills are available from `.claude/skills`.

This repository also includes Claude Code slash commands in `.claude/commands`. In Claude Code, `/ayo`, `/oya`, `/ayo-bro`, and `/fuck` are useful fallbacks if plain text commands are not picked up by the skill matcher.

For global use, copy all skills to your Claude skills directory:

```bash
mkdir -p ~/.claude/skills
cp -R skills/* ~/.claude/skills/
mkdir -p ~/.claude/commands
cp .claude/commands/*.md ~/.claude/commands/
```

## Codex

Install globally so Codex can discover all AYO skills:

```powershell
.\scripts\install.ps1
```

On Windows, run `install.ps1` from PowerShell. If you are using Command Prompt (`cmd.exe`), run:

```cmd
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1
```

Do not double-click `install.ps1` or choose "Open" from the Windows security dialog. That may open the script as a text file instead of running it.

If PowerShell blocks the script, run this first in the same PowerShell window:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

Or copy it manually:

```powershell
New-Item -ItemType Directory -Force "$env:USERPROFILE\.codex\skills" | Out-Null
Copy-Item -Recurse -Force .\skills\* "$env:USERPROFILE\.codex\skills\"
```

On macOS/Linux:

```bash
./scripts/install.sh
```

## Usage

After installation and restart, Codex should discover these skill names:

```text
ayo
oya
ayo-bro
fuck
```

If Codex only shows `/ayo` in the slash menu, you are using an older install or an old chat session. Run the installer again from the latest downloaded folder, then fully restart Codex or open a brand-new chat.

To create a handoff, type:

```text
ayo
```

In Claude Code, you can also type:

```text
/ayo
```

The AI should create an `ayo-handoffs` folder in the current project directory and save the Markdown handoff there. The full document should not be pasted into the chat by default.

Expected chat response:

```text
Created handoff document: <project-directory>/ayo-handoffs/handoff-YYYYMMDD-HHMMSS.md
```

To resume from the latest handoff, type:

```text
oya
```

In Claude Code, you can also type:

```text
/oya
```

The AI should read the latest Markdown file in `ayo-handoffs`, summarize the current goal and progress, propose the next action, and ask for confirmation before making changes or running project-changing commands.

To create a safe project checkpoint, type:

```text
ayo bro
```

In Claude Code, you can also type:

```text
/ayo-bro
```

The AI should:

- Initialize Git automatically if the project does not already use Git.
- Create or update `.ayo/memory.md`.
- Create or update `.ayo/checkpoints.json`.
- Commit a safe project-state checkpoint with a message like `AYO_CHECKPOINT_20260611_2105`.
- Record the checkpoint id, commit hash, time, and summary.
- Replace the previous AYO checkpoint record so `fuck` restores only the newest save point.

To restore the latest checkpoint, type:

```text
fuck
```

In Claude Code, you can also type:

```text
/fuck
```

The AI should read `.ayo/checkpoints.json`, show the latest checkpoint, ask for confirmation, then restore the project to that Git commit only after the user confirms. Before restoring, it should preserve current uncommitted work with a Git stash backup when needed.

Note: older Git commits may still exist in Git history, but AYO only keeps and restores the latest checkpoint recorded in `.ayo/checkpoints.json`.

## Important: Restart After Installing

After running the installer, fully restart Codex or Claude Code, or open a brand-new chat. Existing chats may not reload newly installed skills.

This project is for AI environments that support local skills, such as Codex and Claude Code. Ordinary ChatGPT web/app chats do not automatically load local files from `~/.codex/skills` or `~/.claude/skills`.

If typing `ayo` produces a normal greeting instead of creating a file, the skill was not loaded by that chat.

Check installation on Windows:

```powershell
Test-Path "$env:USERPROFILE\.codex\skills\ayo\SKILL.md"
Test-Path "$env:USERPROFILE\.codex\skills\oya\SKILL.md"
Test-Path "$env:USERPROFILE\.codex\skills\ayo-bro\SKILL.md"
Test-Path "$env:USERPROFILE\.codex\skills\fuck\SKILL.md"
Test-Path "$env:USERPROFILE\.claude\skills\ayo\SKILL.md"
Test-Path "$env:USERPROFILE\.claude\skills\oya\SKILL.md"
Test-Path "$env:USERPROFILE\.claude\skills\ayo-bro\SKILL.md"
Test-Path "$env:USERPROFILE\.claude\skills\fuck\SKILL.md"
Test-Path "$env:USERPROFILE\.claude\commands\ayo.md"
Test-Path "$env:USERPROFILE\.claude\commands\oya.md"
Test-Path "$env:USERPROFILE\.claude\commands\ayo-bro.md"
Test-Path "$env:USERPROFILE\.claude\commands\fuck.md"
```

All commands should return `True`.

## Notes

- The skill can only read conversation context and files that the current AI environment exposes.
- It should not include secrets, tokens, cookies, or unrelated private data.
- If no workspace files are available, it still creates the handoff from the chat history.

## Uninstall

To remove the installed skill and Claude Code command on Windows:

```powershell
Remove-Item -Recurse -Force "$env:USERPROFILE\.codex\skills\ayo" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:USERPROFILE\.codex\skills\oya" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:USERPROFILE\.codex\skills\ayo-bro" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:USERPROFILE\.codex\skills\fuck" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:USERPROFILE\.claude\skills\ayo" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:USERPROFILE\.claude\skills\oya" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:USERPROFILE\.claude\skills\ayo-bro" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:USERPROFILE\.claude\skills\fuck" -ErrorAction SilentlyContinue
Remove-Item -Force "$env:USERPROFILE\.claude\commands\ayo.md" -ErrorAction SilentlyContinue
Remove-Item -Force "$env:USERPROFILE\.claude\commands\oya.md" -ErrorAction SilentlyContinue
Remove-Item -Force "$env:USERPROFILE\.claude\commands\ayo-bro.md" -ErrorAction SilentlyContinue
Remove-Item -Force "$env:USERPROFILE\.claude\commands\fuck.md" -ErrorAction SilentlyContinue
```

To remove the downloaded project folder, delete the folder you extracted or cloned. For example:

```powershell
Remove-Item -Recurse -Force "D:\Downloads\ayo_skill-main"
```

Check that it was removed:

```powershell
Test-Path "$env:USERPROFILE\.codex\skills\ayo\SKILL.md"
Test-Path "$env:USERPROFILE\.codex\skills\oya\SKILL.md"
Test-Path "$env:USERPROFILE\.codex\skills\ayo-bro\SKILL.md"
Test-Path "$env:USERPROFILE\.codex\skills\fuck\SKILL.md"
Test-Path "$env:USERPROFILE\.claude\skills\ayo\SKILL.md"
Test-Path "$env:USERPROFILE\.claude\skills\oya\SKILL.md"
Test-Path "$env:USERPROFILE\.claude\skills\ayo-bro\SKILL.md"
Test-Path "$env:USERPROFILE\.claude\skills\fuck\SKILL.md"
Test-Path "$env:USERPROFILE\.claude\commands\ayo.md"
Test-Path "$env:USERPROFILE\.claude\commands\oya.md"
Test-Path "$env:USERPROFILE\.claude\commands\ayo-bro.md"
Test-Path "$env:USERPROFILE\.claude\commands\fuck.md"
```

All commands should return `False`.
