Create a Markdown project handoff from the current conversation and available project context.

Follow the same behavior as the `ayo` skill:

1. Reconstruct the current project goal from the conversation.
2. Inspect useful local context when available, including file structure, important files, Git status, and test output.
3. Identify completed work, partial work, blockers, decisions, and next tasks.
4. Create an `ayo-handoffs` folder in the current project directory.
5. Save a new Markdown file named `handoff-YYYYMMDD-HHMMSS.md` in that folder.
6. Do not paste the full handoff in chat. Reply only with the saved file path.

Use this document structure:

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

