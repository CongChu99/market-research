# market-research — Execution Prompt

Follow these steps exactly. Do not skip layers. Do not write the artifact until all 4 layers are complete.

---

## Step 1: Parse Input

Determine which input mode is being used:

**String mode** — user provides a plain text idea:
```
Extract:
- Core product concept
- Implied target users
- Implied platform (web/mobile/CLI/etc)
- Domain keywords for research
```

**Structured mode** — user provides key-value context:
```
idea: <product concept>
target_users: <who uses this>
platform: <web | mobile | desktop | CLI | API>
monetization: <freemium | subscription | one-time | marketplace | free>
```
Parse each field. If a field is missing, infer from the idea string.

**File mode** — user provides a path like `idea.md` or `requirements.md`:
```
Read the file. Extract all structured information.
Treat headings, bullet points, and user stories as structured context.
```

After parsing, confirm your understanding in one short paragraph before proceeding.

**Edge cases:**
- If the idea is very broad (e.g., "social media app"), ask up to 2 clarifying questions to narrow scope before proceeding (e.g., target audience, primary use case).
- If the idea is very niche and likely has no direct competitors, proceed anyway — use adjacent and indirect competitors in Layer 2, and note the niche nature in the output.
- If input is ambiguous enough that the wrong analysis could result, ask 1–2 clarifying questions. Prefer making reasonable assumptions over asking more than 2 questions total.

---

## Step 2: Determine Execution Mode

| Condition | Mode |
|-----------|------|
| User passed `--research` | `research` |
| User said "use research mode" or "deep research" | `research` |
| No flag specified | `fast` (default) |

In **fast mode**: Use only internal knowledge. No web search.
In **research mode**: Search the web for each competitor. Perform separate searches for:
- `"<competitor name> pricing"`
- `"<competitor name> features"`
- `"<competitor name> reviews site:reddit.com OR site:producthunt.com"`

Collect all source URLs used — they will be listed in the `## Sources` section of the output.

---

## Step 3: Layer 1 — Business Domain Analysis

Analyze the core business problem. Do not reference competitors yet.

Produce:
- **Problem Statement** (2–3 sentences): What pain does this solve? For whom? In what context?
- **Target Users**: List 2–4 user personas with role, goal, and key frustration
- **Core Workflows**: List 3–6 primary user workflows as numbered steps
  - Format: `Workflow N: <name>` → `1. step → 2. step → 3. step`
- **Domain Entities**: Key data objects the system manages (e.g., Transaction, Budget, Category)
- **Business Rules**: Constraints and logic the system must enforce (e.g., "Budget cannot exceed income")

---

## Step 4: Layer 2 — Market Landscape

Identify the competitive space.

Produce:
- **Market Category**: Which product category does this belong to? (e.g., "Personal Finance", "Developer Tooling", "Project Management")
- **Market Size Signal**: Is this a crowded, growing, niche, or emerging market? (1 sentence)
- **Competitor List**: Identify 4–8 relevant competitors or alternatives

For each competitor, collect:
```
Name:
Type: [direct | indirect | adjacent]
Target segment:
Pricing model:
Platform:
Key differentiator:
```

In **research mode**: Search the web to verify and enrich each entry.
In **fast mode**: Use internal knowledge only.

---

## Step 5: Layer 3 — Feature Landscape

Build a feature comparison table across top 4–6 competitors.

**Process:**
1. List the 10–15 most important features for this product category
2. For each competitor, mark: `✓` (has it), `△` (partial/limited), `✗` (missing)

**Output format:**
```
| Feature                  | Competitor A | Competitor B | Competitor C | Competitor D |
|--------------------------|-------------|-------------|-------------|-------------|
| Core feature 1           | ✓           | ✓           | ✓           | △           |
| Core feature 2           | ✓           | ✗           | ✓           | ✓           |
| Advanced feature 1       | △           | ✗           | ✓           | ✗           |
...
```

Add a **"Your Product"** column — leave it blank for now (filled in gap analysis).

---

## Step 6: Layer 4 — Gap Analysis

Based on layers 1–3, identify opportunities.

Produce:
- **Feature Gaps**: Features that are missing or poor across most competitors
- **Segment Gaps**: User groups underserved by current market
- **UX/DX Gaps**: Usability or developer experience problems common in existing tools
- **Pricing Gaps**: Underserved price points or model mismatches
- **Integration Gaps**: Missing integrations that target users need

For each gap, format as:
```
Gap: <short name>
Evidence: <which competitors have this problem>
Opportunity: <how you can address it>
Priority: [high | medium | low]
```

---

## Step 7: Synthesize — Differentiation Strategy & MVP Scope

**Differentiation Strategy:**
Based on gaps, write 3–5 bullet points describing how this product will be meaningfully different. Be specific. Avoid generic claims like "better UX" — say *what* specifically will be better and *why*.

**Initial MVP Scope:**
List 5–10 features for a minimal but shippable v1. Prioritize:
- Must-have: solves the core pain
- Should-have: differentiates from competitors
- Exclude: advanced features that can wait

Format:
```
| Feature | Priority | Rationale |
|---------|----------|-----------|
| ...     | must     | ...       |
| ...     | should   | ...       |
```

---

## Step 8: Write Artifact

Derive a kebab-case product name from the idea (e.g., "app quản lý chi tiêu" → `quan-ly-chi-tieu`).

Create directory if needed:
```bash
mkdir -p .ai/research
```

Write the completed analysis to `.ai/research/<product-name>-market-analysis.md` using `template.md` as the structure.

Fill every section. Do not leave placeholders. Do not copy `template.md` comments into the output.

**Fast mode only:** Add a disclaimer at the top of the artifact:
> ⚠️ This analysis was generated in **fast mode** using AI internal knowledge only. Competitor data (pricing, features, market position) may be outdated. Run with `--research` for verified, current data.

---

## Step 9: Confirm & Handoff

After writing the artifact:

1. Show a summary table of key findings (5–7 rows max)
2. Print the artifact path: `.ai/research/<product-name>-market-analysis.md`
3. Suggest next steps:

```
Market analysis complete. Artifact saved to .ai/research/<product-name>-market-analysis.md

Key findings:
- [Problem] ...
- [Market] ...
- [Top gap] ...
- [Differentiator] ...
- [MVP size] N features

Next steps:
- To build: run /opsx:propose and reference the analysis artifact as context.
- To keep as reference: no further action needed.
```

---

## Guardrails

- Complete all 4 layers before writing the artifact — never write partial analysis
- In fast mode, never use web search — use internal knowledge only
- In research mode, search each major competitor individually — do not batch
- Do not fabricate competitor features — if unknown, mark as `?` and note uncertainty
- Do not skip Gap Analysis — it is the most valuable layer for proposal quality
- If input is ambiguous, ask up to 2 clarifying questions before proceeding — prefer reasonable assumptions over excessive questioning
- The artifact must be complete and standalone — readable without this conversation
- In fast mode, always include the outdated-data disclaimer at the top of the artifact
- In research mode, always populate the Sources section with URLs used
