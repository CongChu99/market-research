# market-research

AI skill for structured market & competitor analysis. Analyze any product idea across 4 layers — business domain, market landscape, feature comparison, and gap analysis — before writing a single line of code.

Works with **Claude Code**, **Codex**, **Antigravity (Gemini)**, and **GitHub Copilot**.

## See it in action

```
You: /market-research "personal finance app for college students"

AI: Analyzing...
  ✓ Business Domain — 3 personas, 5 workflows identified
  ✓ Market Landscape — 6 competitors mapped (Mint, YNAB, Goodbudget...)
  ✓ Feature Comparison — 12 features across 4 competitors
  ✓ Gap Analysis — 4 high-priority gaps found

  Artifact saved to .ai/research/personal-finance-market-analysis.md

You: /market-research "personal finance app for college students" --research

AI: Deep research mode — searching the web for each competitor...
  ✓ Verified pricing, features, and reviews from live sources
  ✓ 14 source URLs documented

  Artifact saved to .ai/research/personal-finance-market-analysis.md
```

## Quick Start

Install globally:

```bash
git clone https://github.com/CongChu99/market-research.git
cd market-research
sudo ln -sf $(pwd)/market-research /usr/local/bin/market-research
```

Then navigate to your project and initialize:

```bash
cd your-project
market-research init
```

Now tell your AI: `/market-research "your product idea"`

> [!NOTE]
> Also works without global install. Just run the script directly:
> ```bash
> /path/to/market-research init
> ```

## Installation

### Option 1: Global install (recommended)

```bash
# Clone and link (one-time setup)
git clone https://github.com/CongChu99/market-research.git ~/.market-research
sudo ln -sf ~/.market-research/market-research /usr/local/bin/market-research

# Now use anywhere:
cd any-project
market-research init
```

### Option 2: curl one-liner

```bash
# Download and install in one command
curl -fsSL https://raw.githubusercontent.com/CongChu99/market-research/main/install.sh | bash
```

### Option 3: Manual copy

```bash
# Clone the repo
git clone https://github.com/CongChu99/market-research.git

# Copy skill files into your project
cd your-project
/path/to/market-research init
```

### Selective platform install

```bash
market-research init --only claude          # Claude Code only
market-research init --only codex           # Codex only
market-research init --only antigravity     # Antigravity only
market-research init --only copilot         # GitHub Copilot only
market-research init --only claude codex    # Multiple platforms
```

## Usage

After installing the skill into your project (`market-research init`), open your AI coding assistant and use it directly in chat.

### Fast mode (default)

Uses AI's built-in knowledge. No web search. Best for quick exploration and early ideation.

```
/market-research "meal planning app for busy parents"
```

> [!NOTE]
> Fast mode includes an automatic disclaimer noting that competitor data may be outdated. Use research mode for verified, current data.

### Research mode

Searches the web for each competitor — pricing, features, reviews. Best for serious builds and pre-funding research.

```
/market-research "meal planning app for busy parents" --research
```

### Custom output path

Save the analysis to a custom location:

```
/market-research "meal planning app" --output docs/market-analysis.md
```

### Structured input

Provide detailed context for more targeted analysis:

```
/market-research
idea: AI-powered code review tool
target_users: senior developers, tech leads
platform: web, VS Code extension
monetization: freemium
```

### File input

Point to an existing idea or requirements document:

```
/market-research idea.md
/market-research requirements.md
```

### Platform-specific notes

| Platform | How to invoke | Research mode |
|----------|--------------|:---:|
| **Claude Code** | `/market-research "idea"` | ✅ Full support |
| **Codex** | `/market-research "idea"` | ⚠️ Limited web search |
| **Antigravity** | `Run skill market-research for "idea"` | ✅ Full support |
| **GitHub Copilot** | `/market-research "idea"` | ⚠️ Limited web search |

## What It Produces

Output artifact at `.ai/research/<product-name>-market-analysis.md`:

| Section | What's inside |
|---------|--------------|
| **Problem Statement** | Core pain, target context (2–3 sentences) |
| **Target Users** | 2–4 personas with goals and frustrations |
| **Core Workflows** | 3–6 primary user journeys |
| **Domain Entities** | Key data objects the system manages |
| **Business Rules** | Constraints and logic to enforce |
| **Market Landscape** | 4–8 competitors with type, pricing, platform |
| **Feature Comparison** | 10–15 features across top competitors (✓/△/✗) |
| **Gap Analysis** | Feature, segment, UX, pricing, and integration gaps |
| **Differentiation** | 3–5 specific, concrete differentiators |
| **MVP Scope** | 5–10 features prioritized as must/should/later |
| **Sources** | URLs consulted (research mode) |

## Workflow Integration

This skill is designed as a **pre-proposal step** in the [OpenSpec](https://github.com/Fission-AI/OpenSpec) workflow:

```
market-research "your idea"
        ↓
.ai/research/<name>-market-analysis.md
        ↓
  ┌─────────────────────────────────────────┐
  │  /opsx:propose                          │
  │  → proposal.md + design.md + tasks.md   │
  │                                         │
  │  — or —                                 │
  │                                         │
  │  Keep as standalone reference            │
  └─────────────────────────────────────────┘
```

## Example Output

See [`examples/personal-finance-market-analysis.md`](examples/personal-finance-market-analysis.md) for a complete example of what the skill produces.

## CLI Reference

| Command | Description |
|---------|-------------|
| `market-research init` | Install skill into current project (all platforms) |
| `market-research init --only <platforms>` | Install for specific platform(s) only |
| `market-research status` | Check if skill is installed in current project |
| `market-research update` | Re-install skill files (overwrite with latest) |
| `market-research uninstall` | Remove skill from current project |
| `market-research --version` | Show version |
| `market-research --help` | Show help |

## Updating

Pull latest and re-init in your projects:

```bash
cd ~/.market-research    # or wherever you cloned it
git pull

# Then in each project:
cd your-project
market-research update
```

## Project Structure

```
market-research          # CLI script (bash, executable)
README.md                # This file
install.sh               # One-liner installer
skill/
├── SKILL.md             # Skill entry point — loaded by AI agents
├── prompt.md            # 9-step execution instructions + validation
├── template.md          # Output artifact template
├── project-docs/        # Documentation skill (auto-export)
│   ├── SKILL.md
│   ├── prompt.md
│   └── templates/
│       ├── design.md
│       ├── plan.md
│       └── changelog.md
└── workflows/
    └── build-with-superpowers.md
examples/
└── personal-finance-market-analysis.md  # Example output
```

## Supported AI Tools

| Tool | Skills directory | Status |
|------|-----------------|:---:|
| Claude Code | `.claude/skills/market-research/` | ✅ |
| Codex (OpenAI) | `.codex/skills/market-research/` | ✅ |
| Antigravity (Gemini) | `.agent/skills/market-research/` | ✅ |
| GitHub Copilot | `.github/skills/market-research/` | ✅ |

## Contributing

PRs welcome. If you add a new analysis layer or change the output format, update all three files:

- `skill/SKILL.md` — skill overview and entry point
- `skill/prompt.md` — execution steps
- `skill/template.md` — output artifact structure

## License

MIT
