#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_dir="$repo_root/skills/ayo"
claude_command_source="$repo_root/.claude/commands/ayo.md"

if [[ -n "${CODEX_HOME:-}" ]]; then
  codex_root="$CODEX_HOME/skills"
else
  codex_root="$HOME/.codex/skills"
fi
claude_root="$HOME/.claude/skills"

if [[ ! -d "$source_dir" ]]; then
  echo "Cannot find skill source at $source_dir" >&2
  exit 1
fi

for item in "Codex:$codex_root" "Claude:$claude_root"; do
  name="${item%%:*}"
  target_root="${item#*:}"
  target_dir="$target_root/ayo"

  mkdir -p "$target_root"
  rm -rf "$target_dir"
  cp -R "$source_dir" "$target_dir"
  echo "Installed ayo skill for $name to $target_dir"
done

if [[ -f "$claude_command_source" ]]; then
  claude_commands_root="$HOME/.claude/commands"
  mkdir -p "$claude_commands_root"
  cp "$claude_command_source" "$claude_commands_root/ayo.md"
  echo "Installed Claude Code /ayo command to $claude_commands_root"
fi

echo
echo "Next steps:"
echo "1. Fully restart Codex or Claude Code, or open a brand-new chat after installation."
echo "2. Open the project you want to summarize."
echo "3. Type exactly: ayo"
echo "   In Claude Code, you can also type: /ayo"
echo
echo "Note: ordinary ChatGPT web/app chats do not load local skills from this folder."
