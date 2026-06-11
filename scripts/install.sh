#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skills_source_root="$repo_root/skills"

if [[ -n "${CODEX_HOME:-}" ]]; then
  codex_root="$CODEX_HOME/skills"
else
  codex_root="$HOME/.codex/skills"
fi
claude_root="$HOME/.claude/skills"

if [[ ! -d "$skills_source_root" ]]; then
  echo "Cannot find skills source at $skills_source_root" >&2
  exit 1
fi

for item in "Codex:$codex_root" "Claude:$claude_root"; do
  name="${item%%:*}"
  target_root="${item#*:}"

  mkdir -p "$target_root"
  for skill_source in "$skills_source_root"/*; do
    [[ -d "$skill_source" ]] || continue
    skill_name="$(basename "$skill_source")"
    target_dir="$target_root/$skill_name"
    rm -rf "$target_dir"
    cp -R "$skill_source" "$target_dir"
    echo "Installed $skill_name skill for $name to $target_dir"
  done
done

claude_commands_root="$HOME/.claude/commands"
if [[ -d "$repo_root/.claude/commands" ]]; then
  mkdir -p "$claude_commands_root"
  for command_source in "$repo_root"/.claude/commands/*.md; do
    [[ -e "$command_source" ]] || continue
    cp "$command_source" "$claude_commands_root/$(basename "$command_source")"
    command_name="$(basename "$command_source" .md)"
    echo "Installed Claude Code /$command_name command to $claude_commands_root"
  done
fi

echo
echo "Next steps:"
echo "1. Fully restart Codex or Claude Code, or open a brand-new chat after installation."
echo "2. Open the project you want to summarize."
echo "3. Type exactly: ayo, oya, ayo bro, or fuck"
echo "   In Claude Code, you can also type: /ayo, /oya, /ayo-bro, or /fuck"
echo
echo "Note: ordinary ChatGPT web/app chats do not load local skills from this folder."
