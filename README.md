# ayo3.0.0

`ayo` is a chat-triggered AI skill for saving Markdown project handoff documents.

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

## Repository Layout

```text
ayo3.0.0/
  skills/ayo/              # Canonical skill package
  .claude/skills/ayo/      # Claude Code project-level copy
  .claude/commands/ayo.md  # Claude Code slash command fallback
  .codex/skills/ayo/       # Codex project-level copy for compatible environments
  scripts/install.ps1      # Windows installer
  scripts/install.sh       # macOS/Linux installer
```

When the skill runs in a target project, it creates:

```text
ayo-handoffs/
  handoff-YYYYMMDD-HHMMSS.md
```

## Claude Code

Clone this repository and open it with Claude Code. The project-level skill is available from `.claude/skills/ayo`.

This repository also includes a Claude Code slash command at `.claude/commands/ayo.md`. In Claude Code, `/ayo` is a useful fallback if plain `ayo` is not picked up by the skill matcher.

For global use, copy `skills/ayo` to your Claude skills directory:

```bash
mkdir -p ~/.claude/skills
cp -R skills/ayo ~/.claude/skills/ayo
mkdir -p ~/.claude/commands
cp .claude/commands/ayo.md ~/.claude/commands/ayo.md
```

## Codex

Install globally so Codex can discover it:

```powershell
.\scripts\install.ps1
```

Or copy it manually:

```powershell
New-Item -ItemType Directory -Force "$env:USERPROFILE\.codex\skills" | Out-Null
Copy-Item -Recurse -Force .\skills\ayo "$env:USERPROFILE\.codex\skills\ayo"
```

On macOS/Linux:

```bash
./scripts/install.sh
```

## Usage

In a supported AI chat, type:

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

## Important: Restart After Installing

After running the installer, fully restart Codex or Claude Code, or open a brand-new chat. Existing chats may not reload newly installed skills.

This project is for AI environments that support local skills, such as Codex and Claude Code. Ordinary ChatGPT web/app chats do not automatically load local files from `~/.codex/skills` or `~/.claude/skills`.

If typing `ayo` produces a normal greeting instead of creating a file, the skill was not loaded by that chat.

Check installation on Windows:

```powershell
Test-Path "$env:USERPROFILE\.codex\skills\ayo\SKILL.md"
Test-Path "$env:USERPROFILE\.claude\skills\ayo\SKILL.md"
Test-Path "$env:USERPROFILE\.claude\commands\ayo.md"
```

All commands should return `True`.

## Notes

- The skill can only read conversation context and files that the current AI environment exposes.
- It should not include secrets, tokens, cookies, or unrelated private data.
- If no workspace files are available, it still creates the handoff from the chat history.
