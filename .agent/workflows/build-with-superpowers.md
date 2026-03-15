---
description: Full build workflow - market research first, then Superpowers for design, planning, implementation, and review
---

# Build with Superpowers

Combined workflow: run **market-research** for business analysis, then hand off to **Superpowers** for the entire development lifecycle, with **project-docs** auto-exporting structured documentation at each phase.

## Prerequisites

- `market-research` skill installed (`.agent/skills/market-research/`)
- `project-docs` skill installed (`.agent/skills/project-docs/`)
- [Superpowers](https://github.com/obra/superpowers) installed in the project

### Install Superpowers

**Claude Code:**
```bash
/plugin install superpowers@claude-plugins-official
```

**Codex / Antigravity:**
```
Fetch and follow instructions from https://raw.githubusercontent.com/obra/superpowers/refs/heads/main/.codex/INSTALL.md
```

**Gemini CLI:**
```bash
gemini extensions install https://github.com/obra/superpowers
```

---

## Workflow Steps

### Phase 1 — Market Research (your skill)

```
/market-research "your idea here"
/market-research "your idea here" --research    # deep mode with web search
```

**Output:** `.ai/research/<product-name>-market-analysis.md`

Contains: business domain, competitor landscape, feature comparison, gap analysis.

---

### Phase 2 — Brainstorming (Superpowers)

Start a new session and reference the market analysis:

> "I want to build `<product-name>`. Here's my market analysis: `.ai/research/<product-name>-market-analysis.md`. Let's brainstorm the design."

Superpowers `brainstorming` skill activates automatically:
- Refines the idea through Socratic questions
- Presents design in digestible sections for your approval
- Saves a design document

**📄 project-docs:** After design approval, auto-generates `docs/<project>/design.md` with structured format (architecture, decisions table, trade-offs, data model).

**Output:** Design doc (approved by you) + `docs/<project>/design.md`

---

### Phase 3 — Planning (Superpowers)

After you approve the design, Superpowers `writing-plans` activates:
- Breaks work into bite-sized tasks (2-5 minutes each)
- Every task has exact file paths, complete code, and verification steps

**📄 project-docs:** After plan approval, auto-generates `docs/<project>/plan.md` with task table, acceptance criteria, risks, and timeline.

**Output:** Implementation plan + `docs/<project>/plan.md`

---

### Phase 4 — Implementation (Superpowers)

After plan approval, choose one:

| Mode | Skill | How it works |
|------|-------|-------------|
| **Subagent** | `subagent-driven-development` | Fresh subagent per task, two-stage review (spec + code quality) |
| **Batch** | `executing-plans` | Batch execution with human checkpoints |

Both enforce:
- `test-driven-development` — RED → GREEN → REFACTOR
- `using-git-worktrees` — Isolated workspace on new branch
- `requesting-code-review` — Automated review between tasks

---

### Phase 5 — Finish (Superpowers)

`finishing-a-development-branch` activates when tasks complete:
- Verifies all tests pass
- Presents options: merge / PR / keep / discard
- Cleans up worktree

**📄 project-docs:** After finish, auto-generates `docs/<project>/changelog.md` with features added, files changed, test summary, and known issues.

**Output:** Merged code + `docs/<project>/changelog.md`

---

## Documentation Output

After a full cycle, your `docs/` folder contains:

```
docs/<project-name>/
├── design.md       # Architecture, decisions, trade-offs
├── plan.md         # Tasks, acceptance criteria, timeline
└── changelog.md    # What was built, tested, known issues
```

All docs are committed to git for team visibility.

Run `/project-docs sync` at any time to regenerate all docs from current context.

---

## Quick Reference

```
Phase 1:  /market-research "idea"          → .ai/research/<name>-market-analysis.md
Phase 2:  "Let's brainstorm <name>"        → design doc + docs/<name>/design.md
Phase 3:  Approve design                   → plan + docs/<name>/plan.md
Phase 4:  "Go"                             → code + tests + reviews
Phase 5:  All tasks done                   → merge/PR + docs/<name>/changelog.md
```

## Notes

- Superpowers skills trigger **automatically** based on context — no slash commands needed after Phase 1.
- `project-docs` triggers **automatically** at phase transitions — no manual action needed.
- The market analysis artifact serves as key context for Superpowers brainstorming.
- You stay in control: every phase requires your approval before proceeding.
