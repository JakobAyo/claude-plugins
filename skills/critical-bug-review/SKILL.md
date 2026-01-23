---
name: critical-bug-review
description: Perform code review focused exclusively on finding critical functional bugs that could break application functionality. Analyzes codebase for bugs that could cause application failures, data corruption, or incorrect business logic. Outputs findings to docs/code-review/ using a structured template.
user_invocable: true
---

# Critical Bug Review Skill

## Purpose

Perform targeted code review to identify **critical functional bugs only**. This skill ignores code style, performance optimizations, security issues, and minor issues to focus exclusively on bugs that could **break the functionality** of the code:

- Application crashes or failures
- Data corruption or loss
- Incorrect business logic or calculations
- Race conditions and concurrency issues
- Null/undefined reference errors
- Unhandled edge cases that break functionality

## When to Use

Invoke this skill with `/critical-bug-review` when you need to:

- Review a specific file, module, or the entire codebase for critical bugs
- Prepare for a production deployment
- Audit code quality for functional correctness
- Identify high-priority issues that need immediate attention

## Scope Definition

### In Scope (Critical Functional Bugs)

| Category                    | Examples                                                             |
| --------------------------- | -------------------------------------------------------------------- |
| **Logic Errors**            | Incorrect conditionals, wrong operators, off-by-one errors           |
| **Null Safety**             | Unhandled null/undefined, missing null checks before access          |
| **Type Errors**             | Type mismatches, incorrect type assertions, missing type guards      |
| **State Management**        | Race conditions, stale state, incorrect state transitions            |
| **Data Integrity**          | Missing validation, data corruption paths, incorrect transformations |
| **Error Handling**          | Unhandled exceptions, swallowed errors, incorrect error propagation  |
| **API Contract Violations** | Incorrect request/response handling, missing required fields         |
| **Resource Leaks**          | Unclosed connections, memory leaks, file handle leaks                |
| **Boundary Conditions**     | Array bounds, integer overflow, division by zero                     |

### Out of Scope (Do NOT Report)

- Code style and formatting
- Naming conventions
- Missing documentation or comments
- Performance optimizations (unless causing functional failure)
- Test coverage gaps
- Code duplication
- Unused imports or variables
- Minor refactoring opportunities
- **Security vulnerabilities** (injection, XSS, authentication issues, etc.)
- Security best practices

## Review Process

### Step 1: Scope Identification

When invoked, ask the user to specify the review scope:

- **Full codebase**: Review all source files in apps/, packages/, services/, clients/, shared/
- **Specific app/package**: Review a single workspace (e.g., `apps/metris.web`)
- **Specific file(s)**: Review provided file path(s)

### Step 2: Systematic Analysis

For each file/module in scope:

1. **Read the code** thoroughly
2. **Trace data flow** through functions and components
3. **Identify entry points** and how data enters the system
4. **Check error paths** for proper handling
5. **Verify state transitions** are valid
6. **Look for edge cases** that aren't handled
7. **Validate business logic** correctness

### Step 3: Bug Documentation

For each critical bug found, document using the template in [OUTPUT_TEMPLATE.md](./OUTPUT_TEMPLATE.md).

### Step 4: Generate Report

Create a markdown report in `docs/code-review/` following the structure defined in [OUTPUT_TEMPLATE.md](./OUTPUT_TEMPLATE.md).

## Output

See [OUTPUT_TEMPLATE.md](./OUTPUT_TEMPLATE.md) for:

- Report structure and format
- Bug entry template
- Example bug entries
- File naming conventions

## Execution Workflow

When this skill is invoked:

1. **Clarify scope** with the user if not specified
2. **Use Task tool** with Explore agent to understand codebase structure if needed
3. **Read files systematically** in the scope
4. **Identify critical bugs** using the criteria above
5. **Document each bug** using the template from OUTPUT_TEMPLATE.md
6. **Create the report** in docs/code-review/
7. **Present summary** to the user

## Important Notes

- Focus ONLY on functional bugs that affect correctness
- Be specific about reproduction steps - developers need to validate findings
- Provide actionable fix suggestions
- Do not pad the report with style or minor issues
- If no critical bugs are found, state that clearly in the report
- For large codebases, break the review into logical chunks

---

**Skill Status**: Active
**Output Location**: `docs/code-review/`
