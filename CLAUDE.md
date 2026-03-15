# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Key CLI Commands

This workspace uses the `openspec` CLI. Core commands:

```bash
# List active changes
openspec list --json

# Check status of a change (artifacts, completion)
openspec status --change "<name>" --json

# Create a new change
openspec new change "<name>"

# Get artifact creation instructions
openspec instructions <artifact-id> --change "<name>" --json

# Get apply (implementation) instructions
openspec instructions apply --change "<name>" --json
```

## Architecture

This is an **OpenSpec workflow workspace** — a spec-driven development system where work is organized into "changes" (features/fixes) that progress through artifact phases before implementation.

### Directory Structure

```
openspec/
  config.yaml              # Project context and per-artifact rules
  changes/
    <change-name>/         # Active change
      .openspec.yaml       # Change metadata
      proposal.md          # What & why
      design.md            # How (architecture decisions)
      tasks.md             # Implementation checklist (- [ ] items)
      specs/               # Delta specs (optional, capability-scoped)
    archive/
      YYYY-MM-DD-<name>/   # Completed changes

.claude/
  skills/                  # OpenSpec skill definitions
  commands/opsx/           # Slash command implementations

.github/skills/            # Same skills for GitHub Copilot
.agent/skills/             # Same skills for other agents
.codex/skills/             # Same skills for Codex
```

### Workflow Model

The core workflow is: **Explore → Propose → Apply → Archive**

1. **Propose** (`/opsx:propose`): Creates a change with `proposal.md`, `design.md`, and `tasks.md` artifacts in dependency order using `openspec instructions <artifact-id>`
2. **Apply** (`/opsx:apply`): Reads context files from CLI output, implements tasks one by one, marking `- [ ]` → `- [x]` as completed
3. **Archive** (`/opsx:archive`): Moves completed change to `openspec/changes/archive/YYYY-MM-DD-<name>/`, optionally syncing delta specs to `openspec/specs/`
4. **Explore** (`/opsx:explore`): Thinking-only mode — read/investigate but never write application code

### Schema: spec-driven

The default schema (`openspec/config.yaml`) is `spec-driven`. The `applyRequires` field (from `openspec status --json`) determines which artifacts must exist before implementation can begin.

### Key Invariants

- `context` and `rules` fields from `openspec instructions` are constraints for the AI — never copy them into artifact files
- Task checkboxes in `tasks.md` are the source of truth for implementation progress
- Delta specs live at `openspec/changes/<name>/specs/`; main specs live at `openspec/specs/<capability>/spec.md`
- Archive naming is always `YYYY-MM-DD-<change-name>`

## Skills

The four workflow skills are duplicated across `.claude/skills/`, `.github/skills/`, `.agent/skills/`, and `.codex/skills/` for cross-platform compatibility. The canonical versions for Claude Code are in `.claude/skills/` and `.claude/commands/opsx/`.
