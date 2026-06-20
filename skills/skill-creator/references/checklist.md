# Skill quick checklist

From Anthropic's guide, "Reference A: Quick checklist". Run through this before declaring a skill done.

## Before you start
- [ ] Identified 2–3 concrete use cases
- [ ] Tools identified (built-in or MCP)
- [ ] Reviewed `references/conventions.md` and an example skill
- [ ] Planned folder structure

## During development
- [ ] Folder named in kebab-case
- [ ] `SKILL.md` file exists (exact spelling, case-sensitive)
- [ ] YAML frontmatter wrapped in `---` delimiters
- [ ] `name` field: kebab-case, no spaces, no capitals, matches folder
- [ ] `description` includes WHAT it does and WHEN to use it
- [ ] `description` under 1024 characters
- [ ] No XML tags (`<` `>`) anywhere in frontmatter
- [ ] No `README.md` inside the skill folder
- [ ] Instructions are clear and actionable
- [ ] Error handling / troubleshooting included
- [ ] Examples provided
- [ ] References clearly linked
- [ ] `name` is not reserved (no `claude` / `anthropic`)

## Before share / upload
- [ ] Tested triggering on obvious tasks
- [ ] Tested triggering on paraphrased requests
- [ ] Verified it does NOT trigger on unrelated topics
- [ ] Functional tests pass
- [ ] Tool integration works (if applicable)
- [ ] Compressed as a `.zip` (for Claude.ai upload)

## After share / upload
- [ ] Test in real conversations
- [ ] Monitor for under/over-triggering
- [ ] Collect user feedback
- [ ] Iterate on description and instructions
- [ ] Bump `version` in `metadata`
