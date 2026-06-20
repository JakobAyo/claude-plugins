# Skill-authoring conventions

Distilled from Anthropic's *Complete Guide to Building Skills for Claude*. This is the authoritative rule set for the `skill-creator` skill. Read it before scaffolding.

## What a skill is

A folder that teaches Claude a repeatable task. Contents:

| Path | Required | Purpose |
|------|----------|---------|
| `SKILL.md` | **Yes** | Instructions in Markdown + YAML frontmatter. |
| `scripts/` | No | Executable code (Python, Bash, etc.). |
| `references/` | No | Documentation loaded on demand. |
| `assets/` | No | Templates, fonts, icons used in output. |

Skills are portable (identical across Claude.ai, Claude Code, and API) and composable (multiple load at once — never assume yours is the only capability available).

## Progressive disclosure (the three levels)

1. **Frontmatter** — always loaded into the system prompt. Just enough for Claude to decide *when* to load the skill.
2. **SKILL.md body** — loaded when Claude judges the skill relevant. Full instructions and guidance.
3. **Linked files** (`references/`, `scripts/`, `assets/`) — loaded only when Claude navigates to them.

Goal: minimize tokens while keeping expertise available. Keep `SKILL.md` focused; move heavy detail down a level.

## Critical naming rules

- **`SKILL.md`** — exactly that, case-sensitive. `SKILL.MD`, `skill.md` are rejected with "Could not find SKILL.md in uploaded folder".
- **Folder name** — kebab-case only. `notion-project-setup` ✅. No spaces, no underscores (`notion_project_setup` ❌), no capitals (`NotionProjectSetup` ❌).
- **No `README.md`** inside the skill folder — all docs live in `SKILL.md` or `references/`. (When distributing on GitHub, a repo-level README outside the skill folder is still wanted for human visitors.)

## Frontmatter fields

### `name` (required)
- kebab-case only, no spaces or capitals.
- Should match the folder name.

### `description` (required) — the most important field
Claude reads this to decide whether to load the skill. Structure:

```
[What it does] + [When to use it] + [Key capabilities / triggers]
```

Rules:
- **Must include both** what the skill does AND when to use it (trigger conditions).
- Under **1024 characters**.
- **No XML tags** (`<` or `>`) — frontmatter enters Claude's system prompt; brackets risk instruction injection and the skill won't load.
- Include specific tasks users might actually say.
- Mention file types if relevant.

Good examples:
```
description: Analyzes Figma design files and generates developer handoff documentation. Use when user uploads .fig files, asks for "design specs", "component documentation", or "design-to-code handoff".

description: Manages Linear project workflows including sprint planning, task creation, and status tracking. Use when user mentions "sprint", "Linear tasks", "project planning", or asks to "create tickets".
```

Bad examples:
```
description: Helps with projects.                          # too vague
description: Creates sophisticated multi-page docs.        # missing triggers
description: Implements the Project entity model.          # too technical, no user triggers
```

### Optional fields
- `license` — for open-source skills (e.g. `MIT`, `Apache-2.0`).
- `compatibility` — 1–500 chars. Environment requirements: intended product, required system packages, network access, MCP servers needed.
- `metadata` — free key-value pairs. Suggested keys: `author`, `version`, `mcp-server`.

### Reserved / forbidden
- Names containing `claude` or `anthropic` are reserved — rejected.
- XML angle brackets anywhere in frontmatter — forbidden.

## File structure (canonical)

```
your-skill-name/
├── SKILL.md              # Required - main skill file
├── scripts/              # Optional - executable code
│   ├── process_data.py
│   └── validate.sh
├── references/           # Optional - documentation
│   ├── api-guide.md
│   └── examples/
└── assets/               # Optional - templates, fonts, etc.
    └── report-template.md
```

## Writing effective instructions

- **Be specific and actionable.** Good: ``Run `python scripts/validate.py --input {file}` to check format. If validation fails, common issues include: missing required fields, invalid date formats (use YYYY-MM-DD).`` Bad: "Validate the data before proceeding."
- **Include error handling.** Add a `## Common Issues` / troubleshooting section with cause + solution per error.
- **Reference bundled resources clearly.** e.g. ``Before writing queries, consult `references/api-patterns.md` for rate limiting, pagination, and error codes.``
- **Lead with critical instructions.** Put must-not-skip rules near the top; use `## Important` / `## Critical` headers; repeat key points if needed.
- **Keep `SKILL.md` under ~5,000 words.** Move detail to `references/` and link to it.
- For critical validations, prefer a bundled **script** (deterministic) over relying on language interpretation.

## The three common use-case categories

1. **Document & Asset Creation** — consistent high-quality output (docs, slides, apps, designs, code). Techniques: embedded style guides, template structures, quality checklists, no external tools.
2. **Workflow Automation** — multi-step processes needing consistent methodology. Techniques: step-by-step with validation gates, templates, built-in review, iterative refinement.
3. **MCP Enhancement** — workflow guidance on top of an MCP server's tools. Techniques: sequencing MCP calls, embedding domain expertise, error handling for common MCP issues.

## The five reusable patterns

1. **Sequential workflow orchestration** — multi-step in a fixed order. Techniques: explicit step ordering, dependencies between steps, validation at each stage, rollback on failure.
2. **Multi-MCP coordination** — workflow spans multiple services. Techniques: clear phase separation, data passing between phases, validate before next phase, centralized error handling.
3. **Iterative refinement** — quality improves with iteration. Techniques: explicit quality criteria, validation scripts, refinement loops, know when to stop.
4. **Context-aware tool selection** — same outcome, different tools by context. Techniques: clear decision criteria, fallback options, explain the choice to the user.
5. **Domain-specific intelligence** — skill adds specialized knowledge beyond tool access. Techniques: domain expertise in logic, checks before action, governance/audit trail.

## Defining success (aspirational targets)

Quantitative: triggers on ~90% of relevant queries; completes workflow in X tool calls; ~0 failed API calls per workflow. Qualitative: users don't need to prompt next steps; workflows complete without correction; consistent results across sessions.

## Testing

Three areas:
1. **Triggering** — triggers on obvious tasks and paraphrases; does NOT trigger on unrelated topics. Build a "Should trigger / Should NOT trigger" list.
2. **Functional** — valid outputs, API calls succeed, error handling works, edge cases covered.
3. **Performance comparison** — measure with vs. without the skill (round-trips, failed calls, tokens).

Debugging trigger problems: ask Claude *"When would you use the [skill name] skill?"* — it quotes the description back; adjust from what's missing.

## Troubleshooting matrix

| Symptom | Cause | Fix |
|---------|-------|-----|
| "Could not find SKILL.md" | Not named exactly `SKILL.md` | Rename (case-sensitive); verify with `ls -la`. |
| "Invalid frontmatter" | Missing `---` delimiters, or unclosed quotes | Wrap frontmatter in `---` … `---`; balance quotes. |
| "Invalid skill name" | Name has spaces or capitals | Use kebab-case (`my-cool-skill`). |
| Skill never triggers (under-triggering) | Description too vague / no trigger phrases | Add detail, keywords, and the phrases users actually type. |
| Skill triggers too often (over-triggering) | Description too broad | Add negative triggers ("Do NOT use for…"), be more specific, clarify scope. |
| Loads but instructions ignored | Verbose / buried / ambiguous instructions | Make concise, move critical rules to top under `## Important`, replace vague phrasing with explicit checks. |
| MCP calls fail | Server not connected / auth / wrong tool names | Verify connection, check auth/scopes, test MCP directly, confirm tool names (case-sensitive). |
| Slow / degraded responses | SKILL.md too large, too many skills enabled | Move docs to `references/`, keep under 5,000 words, reduce simultaneously enabled skills. |

## Distribution (Jan 2026 model)

Individual: download folder → zip → upload in Claude.ai (Settings > Capabilities > Skills) or place in the Claude Code skills directory. Org: admins deploy workspace-wide with automatic updates. API: `/v1/skills` endpoint; add via `container.skills` on Messages API (requires Code Execution Tool beta). Skills are an open standard ("Agent Skills") — use the `compatibility` field for platform-specific needs.
