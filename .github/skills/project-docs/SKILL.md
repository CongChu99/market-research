---
name: project-docs
description: Auto-export structured documentation after each development phase. Ensures design decisions, plans, and changelogs are saved as standardized artifacts in docs/ for team visibility and long-term reference.
---

# project-docs

## Overview

Automatically generate and maintain structured project documentation throughout the development lifecycle. Works alongside Superpowers to capture outputs from brainstorming, planning, and implementation phases into standardized, team-readable files.

## When to Use

This skill activates **automatically** at phase transitions during `/build-with-superpowers` workflow:

| Trigger | Action |
|---------|--------|
| After **brainstorming** phase completes | Generate `docs/<project>/design.md` |
| After **planning** phase completes | Generate `docs/<project>/plan.md` |
| After **implementation** finishes | Generate `docs/<project>/changelog.md` |
| On demand | `/project-docs sync` to regenerate all |

## Output Structure

```
docs/<project-name>/
├── design.md       # Architecture, decisions, trade-offs
├── plan.md         # Implementation tasks with status
└── changelog.md    # What was built, tested, deployed
```

All files are committed to version control for team access.

## Execution

Follow `prompt.md` step by step for each document type.

## Quick Reference

```
/project-docs design    # Generate design doc from current context
/project-docs plan      # Generate plan doc from current context
/project-docs changelog # Generate changelog from git history
/project-docs sync      # Regenerate all docs for current project
```
