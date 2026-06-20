---
name: <your-skill-name>
description: <What it does> <When to use it — include the specific phrases a user would say, and mention file types if relevant.> Keep under 1024 characters. No XML angle brackets.
# Optional fields — delete any you don't use:
# license: MIT
# compatibility: <environment needs, 1-500 chars, e.g. "Requires the Linear MCP server and network access.">
# metadata:
#   author: <name>
#   version: 1.0.0
#   mcp-server: <server-name>
---

# <Your Skill Name>

<One-paragraph summary: what this skill produces and the value it delivers. Focus on the outcome, not the mechanics.>

## When to invoke

- User says: <trigger phrase 1>, <trigger phrase 2>, <trigger phrase 3>.
- <Other situations that should load this skill.>

Do **not** invoke for:
- <Adjacent case handled elsewhere — name the other skill or approach.>

## Inputs

<What you need from the user before starting. Batch any questions into one ask. Default sensibly; don't guess on irreversible choices.>

## Workflow

1. **<First major step>.** <Clear explanation of what happens and why.>
2. **<Next step>.** <…> For scripted steps, show the literal command:
   ```bash
   python3 scripts/<script>.py --input <file>
   ```
   Expected output: <describe what success looks like>.
3. **Validate / self-check.** <How the skill confirms it did the right thing.>
4. **Report.** <What to tell the user when done — paths, summary, anything to review.>

## Important

<Critical rules that must not be skipped. Put the highest-stakes constraints here, near the top of attention. Use ## Important or ## Critical headers so they stand out.>

## Examples

### Example 1: <common scenario>

User says: "<what the user types>"

Actions:
1. <step>
2. <step>

Result: <what the user ends up with>.

## Troubleshooting

### <Common error or symptom>

**Cause:** <why it happens>
**Solution:** <how to fix it>

## References

- `references/<file>.md` — <what it contains and when to read it>.
- `scripts/<file>.py` — <what it does>.
