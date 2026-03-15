---
name: market-research
description: Use when starting a new product idea, feature proposal, or problem statement and needing structured business domain analysis, competitor landscape, feature gap analysis, and differentiation strategy before writing a proposal.
---

# market-research

## Overview

Analyze a product idea from business and market perspectives and produce a structured artifact ready to use as a foundation for `/opsx:propose`.

Run this skill **before** creating an OpenSpec change. The output feeds directly into `proposal.md` and `design.md`.

## When to Use

- You have a product idea but haven't created an OpenSpec change yet
- You need to understand the competitive landscape before writing a proposal
- You want to identify market gaps and differentiation before scoping MVP
- Input is a rough idea string, structured context, or an existing requirements file

**Not for:** Post-proposal research, implementation decisions, or technical architecture — those belong in `design.md`.

## Input Modes

| Mode | Format | Example |
|------|--------|---------|
| **String** | Plain idea text | `"app quản lý chi tiêu cá nhân cho sinh viên"` |
| **Structured** | Key-value context block | See prompt.md |
| **File** | Path to `idea.md` or `requirements.md` | `idea.md` |

## Analysis Layers

1. **Business Domain** — users, core workflows, domain entities, business rules
2. **Market Landscape** — competitors, categories, pricing models
3. **Feature Landscape** — feature comparison table across top competitors
4. **Gap Analysis** — missing features, unserved segments, weak UX patterns

## Execution Modes

| Mode | Web Search | Depth | Use When |
|------|-----------|-------|----------|
| `fast` (default) | No | Knowledge-based | Quick exploration, early ideation |
| `research` | Yes (web search) | Deep competitor research | Pre-proposal, funding prep, serious builds |

Activate research mode by appending `--research` or stating "use research mode".

## Options

| Flag | Description | Default |
|------|-------------|---------|
| `--research` | Enable deep web search mode | Off (fast mode) |
| `--output <path>` | Custom output file path | `.ai/research/<name>-market-analysis.md` |

## Output

Always writes to: `.ai/research/<product-name>-market-analysis.md`

See `template.md` for full artifact structure.

## Execution

Follow `prompt.md` step by step.

## Quick Reference

```
/market-research "your idea here"
/market-research "your idea here" --research
/market-research "your idea here" --output docs/analysis.md
/market-research idea.md
```

After completion:
- To build: run `/opsx:propose` and reference the analysis artifact as context.
- To keep as reference: no further action needed — the analysis is a standalone document.
