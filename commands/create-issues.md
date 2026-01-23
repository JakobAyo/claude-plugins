# Create GitHub Issues from Bug Report File

You are tasked with creating GitHub issues from a bug report file located at **$ARGUMENTS**.

## Instructions

Follow these steps carefully:

### Step 1: Read and Parse the Bug Report File

First, read the file provided:

```bash
cat "$ARGUMENTS"
```

The file contains one or more bugs formatted using the bug report template. Each bug entry is separated by `---` and follows this structure:

```markdown
## Bug Title

### Expected Behavior

{description}

### Current Behavior

{description}

### Possible Solution

{description}

### Steps to Reproduce

1. {step}
2. {step}
   ...

### Context (Environment)

{description}

### Detailed Description

{description}

### Possible Implementation

{description}

---
```

### Step 2: Extract Each Bug Entry

For each bug found:

1. Extract the bug title (from the `##` heading)
2. Extract all sections (Expected Behavior, Current Behavior, etc.)
3. Track the bug in your todo list

Use TodoWrite to track progress:

- Add each bug as a pending todo item
- Mark as in_progress when creating the issue
- Mark as completed when the issue is successfully created

### Step 3: Create GitHub Issues

For each bug entry, create a GitHub issue using the `gh` CLI. The issue body should follow the bug_report.md template format.

Use this command structure for each bug:

```bash
gh issue create --title "[BUG] {Bug Title}" --label "bug" --body "$(cat <<'EOF'
Issue tracker is **ONLY** used for reporting bugs. New features should be discussed on our slack channel. Please use [stackoverflow](https://stackoverflow.com) for supporting issues.

## Expected Behavior
{extracted expected behavior}

## Current Behavior
{extracted current behavior}

## Possible Solution
{extracted possible solution}

## Steps to Reproduce
{extracted steps}

## Context (Environment)
{extracted context}

## Detailed Description
{extracted detailed description}

## Possible Implementation
{extracted possible implementation}
EOF
)"
```

### Step 4: Report Results

After creating all issues, provide a summary:

1. **Total bugs processed**: {count}
2. **Issues created successfully**: {count}
3. **Failed to create**: {count} (if any)

For each created issue, report:

- Issue number
- Issue title
- Issue URL

## Important Guidelines

- Preserve all formatting and content from each section
- Use exact section names as they appear in the template
- Always show the created issue URL after successful creation
