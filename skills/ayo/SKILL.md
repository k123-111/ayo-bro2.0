---
name: ayo
description: Save a Markdown handoff document from the current AI chat when the user says "ayo" or asks for a project handoff, status summary, continuation note, context transfer, progress report, or next-task document. Use for any project type, not only Git repositories, by reading the visible conversation, available workspace context, and relevant files when useful, then creating an ayo-handoffs folder in the current project directory and writing the handoff to a timestamped .md file.
---

# Ayo

## Purpose

When the user says `ayo`, create a practical Markdown handoff document that lets another AI or human continue the work with minimal context loss, and save it as a file instead of displaying the full document in chat.

Do not treat `ayo` as a greeting. Treat it as an explicit request to summarize the current project state and produce a handoff.

## Workflow

1. Reconstruct the project goal from the conversation first.
2. Inspect local context only when it is useful and available:
   - Current working directory and file tree.
   - Important source/config/document files.
   - Git status, recent commits, or diffs if the workspace is a Git repository.
   - Running commands, test output, logs, or app URLs mentioned in the chat.
3. Identify what is complete, partially complete, blocked, and not started.
4. Determine the project directory:
   - Prefer the current workspace/project root.
   - If inside a Git repository, the Git root is a good project directory.
   - If no project root is detectable, use the current working directory.
5. Create an `ayo-handoffs` folder directly inside the project directory.
6. Save the handoff as a new Markdown file named `handoff-YYYYMMDD-HHMMSS.md` inside `ayo-handoffs`.
7. Reply in chat with only a short success note and the saved file path. Do not paste the full handoff document into chat unless the user explicitly asks to view it.

## Output Requirements

Write the saved Markdown file in the same language the user is using unless they request another language.

Use this structure:

```markdown
# Ayo Handoff

## Project Overview

## Current Goal

## Progress So Far

## Current State

## Project Structure

## Important Files And Context

## Decisions Made

## Open Issues Or Blockers

## Next Tasks

## Suggested Next Prompt
```

Keep the document specific. Prefer concrete file paths, feature names, commands, URLs, branch names, and dates over generic statements.

## File Output

Default output location:

```text
<project-directory>/ayo-handoffs/handoff-YYYYMMDD-HHMMSS.md
```

Use local time for the timestamp when available. Use a filesystem-safe filename.

If a handoff file with the same name already exists, append a short numeric suffix such as `-2`.

After saving, respond with:

```text
Created handoff document: <path>
```

If file writing is unavailable in the current AI environment, explain the blocker briefly and do not paste the full handoff unless the user asks.

## Section Guidance

`Project Overview`: Explain what the project is, who it is for, and the intended outcome.

`Current Goal`: State the immediate objective being pursued in this conversation.

`Progress So Far`: List completed work and verified behavior. Mention tests or checks that passed.

`Current State`: Describe what exists right now, including partial work and any known uncertainty.

`Project Structure`: Summarize the relevant directory and file layout. If the project is large, include only the parts needed for handoff.

`Important Files And Context`: Call out files, commands, tools, environment details, credentials assumptions, external services, or conversation details that matter.

`Decisions Made`: Capture architectural, product, design, naming, workflow, and tradeoff decisions.

`Open Issues Or Blockers`: State unresolved problems, missing information, failing tests, or risks.

`Next Tasks`: Give ordered, actionable tasks. Each task should be clear enough for a new AI agent to start immediately.

`Suggested Next Prompt`: Provide a concise prompt the user can paste into a new AI chat to continue from the handoff.

## Quality Bar

- Be honest about uncertainty. Use "Unknown" rather than inventing details.
- Separate facts from assumptions.
- Do not expose secrets, API keys, tokens, cookies, private credentials, or unrelated personal data.
- Do not over-read the filesystem. Inspect enough to make the handoff useful.
- If no files are available, create the saved handoff from the conversation alone.
- If the conversation is short, still produce the document and mark unknown sections clearly.
