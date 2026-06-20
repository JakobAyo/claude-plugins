---
name: skill-creator
description: Create a new Claude skill that follows Anthropic's official skill-authoring conventions. Walks through use-case definition, kebab-case naming, YAML frontmatter generation, the progressive-disclosure folder layout (SKILL.md + scripts/ + references/ + assets/), instruction writing, and validation. Use when the user says "create a skill", "make a new skill", "build a Claude skill", "scaffold a skill", "write a SKILL.md", or wants to author or package a skill for Claude.
metadata:
  author: jakob
  version: 1.0.0
---

# skill-creator

Author a new, well-formed Claude skill end to end. A skill is a folder Claude loads to learn a repeatable task: a required `SKILL.md` (Markdown + YAML frontmatter) plus optional `scripts/`, `references/`, and `assets/`. This skill turns the rules in Anthropic's *Complete Guide to Building Skills* into a deterministic build workflow.

The non-negotiable conventions are **locked** — they are what makes a skill load reliably. The full rule set lives in `references/conventions.md`; the short list is below. Never relax them to save effort.

## When to invoke

- User says: "create a skill", "make a new skill", "build a Claude skill", "scaffold a skill", "write a SKILL.md", "package this workflow as a skill".
- User describes a repeatable workflow and asks to make Claude do it consistently.

Do **not** invoke for:
- Editing one line of an existing `SKILL.md` — just edit it directly.
- Configuring the harness (hooks, permissions, settings) — use `update-config`.
- Writing project context (`CLAUDE.md`) or end-user docs — use `write-claude-md` / `write-user-manual`.

## Inputs

Gather before scaffolding. Ask in **one** batched `AskUserQuestion` call only for what you genuinely cannot infer:

1. **Use case.** What repeatable task should the skill enable? Push for 2–3 concrete trigger scenarios (the guide: define use cases before writing code).
2. **Skill name.** Derive a kebab-case slug from the use case; confirm it. Must not contain `claude` or `anthropic` (reserved).
3. **Install location.** Default `<repo>/.claude/skills/<name>/` for project skills, or `~/.claude/skills/<name>/` for personal/global. Ask if ambiguous.
4. **Bundled resources.** Does it need `scripts/` (executable code), `references/` (docs loaded on demand), or `assets/` (templates, fonts, icons used in output)? Skip any it doesn't need.

If the use case is vague ("helps with stuff"), stop and clarify — a vague use case produces a vague description, which is the #1 cause of skills that never trigger.

## Workflow

1. **Define success.** Restate the 2–3 use cases and the trigger phrases a user would actually type. These become the `description` and the test cases.
2. **Pick the structure.** Read `references/conventions.md` for the folder layout and progressive-disclosure model. Keep `SKILL.md` lean; push detail into `references/`.
3. **Scaffold.** Copy `references/skill-template.md` to `<location>/<name>/SKILL.md` and fill every `<…>` placeholder. Create only the subfolders the skill needs. Never create a `README.md` inside the skill folder.
4. **Write the frontmatter.** Generate `name` (kebab-case, matches folder) and `description` per the rules below. The description is the highest-leverage text in the whole skill — spend real effort here.
5. **Write the instructions.** In `SKILL.md` body: be specific and actionable, lead with the critical steps, use `## Important` headers for must-not-skip rules, include concrete examples and an error-handling / troubleshooting section. Reference bundled files by relative path (e.g. ``consult `references/api.md` ``).
6. **Validate.** Run:
   ```bash
   python3 scripts/validate_skill.py <location>/<name>
   ```
   It checks naming, frontmatter delimiters, description length and XML-bracket ban, reserved-name ban, and absence of `README.md`. Fix every failure before reporting done.
7. **Write trigger tests.** Add a short "should trigger / should NOT trigger" list to your report (or to a comment), so the user can sanity-check load behavior. To test: ask Claude *"When would you use the <name> skill?"* — it will quote the description back; adjust if the quote is off.
8. **Report.** Give the absolute path, the final `description`, the folder tree created, and the trigger-test list.

## Locked conventions (summary — full list in references/conventions.md)

- **Folder name:** kebab-case only. No spaces, underscores, or capitals. Must match the `name` field. Must not contain `claude` or `anthropic`.
- **Main file:** exactly `SKILL.md` (case-sensitive). No other casing accepted.
- **No `README.md`** inside the skill folder. All docs go in `SKILL.md` or `references/`. (A repo-level README for human visitors is fine — it lives outside the skill folder.)
- **Frontmatter:** opens and closes with `---`. Two required fields.
  - `name` — kebab-case, matches folder name.
  - `description` — `[what it does] + [when to use it] + [trigger phrases]`. Under 1024 characters. **No XML angle brackets (`<` `>`).** Include specific tasks a user would say and mention file types if relevant.
- **Optional frontmatter:** `license`, `compatibility` (1–500 chars, environment needs), `metadata` (free key-value: `author`, `version`, `mcp-server`).
- **Progressive disclosure:** frontmatter (always loaded) → `SKILL.md` body (loaded when relevant) → linked files (loaded on demand). Keep `SKILL.md` under ~5,000 words; move heavy detail to `references/`.

## Rules

- **Description quality is the deliverable.** Vague → under-triggers; too broad → over-triggers. Good: `"Analyzes Figma files and generates handoff docs. Use when user uploads .fig files, asks for 'design specs', or 'design-to-code handoff'."` Bad: `"Helps with projects."`
- **No XML tags anywhere in frontmatter** — frontmatter enters Claude's system prompt; angle brackets risk instruction injection and the skill will fail to load.
- **Validate before declaring done.** Never report success on a skill that fails `validate_skill.py`.
- **Iterate on a single hard case first** (guide's Pro Tip): get one challenging instance working, then generalize into the skill — faster signal than broad testing up front.
- **Show diffs / created paths**, not silent writes. Confirm location before creating files under `~/.claude` or a repo you didn't create.
- **Don't invent capabilities.** If the skill needs an MCP server or external tool, state the dependency in `compatibility`; don't assume it exists.

## References

- `references/conventions.md` — the complete rule set, the three use-case categories, description do's/don'ts, the five workflow patterns, and the full troubleshooting matrix distilled from Anthropic's guide.
- `references/skill-template.md` — the locked SKILL.md starting shape. Copy verbatim, then fill `<…>` placeholders.
- `references/checklist.md` — before-you-start / during-development / before-share / after-share checklist.
- `scripts/validate_skill.py` — validates a skill folder against the locked conventions. Exit code 0 = pass.

## Related skills

- `write-claude-md` — project context for Claude (`CLAUDE.md`), not a reusable skill.
- `update-config` — harness behavior via `settings.json` (hooks, permissions). Use when the user wants automatic behavior the harness must run, not a task Claude performs on request.
