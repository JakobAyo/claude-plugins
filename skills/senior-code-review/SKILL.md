---
name: senior-code-review
description: Professional senior-level code review that generates 5 comprehensive review files. Use when performing code review, reviewing code, analyzing code quality, checking for security issues, finding bugs, assessing performance, or evaluating maintainability. Covers security vulnerabilities, performance bottlenecks, bug analysis, code quality assessment, and maintainability evaluation with consistent templating.
---

# Senior Code Review Skill

## Purpose

Perform comprehensive, professional-grade code reviews at a senior engineer level. This skill generates 5 separate review files, each focusing on a specific aspect of code quality, using a consistent template format.

## When to Use

Automatically activates when you:
- Request a code review or code analysis
- Ask to review code for issues
- Want to check code quality
- Need security or performance analysis
- Want a comprehensive code assessment

## Review Process

### Step 1: Identify Scope

First, determine what code to review:
- Specific files provided by the user
- Recent changes (git diff)
- Entire module or directory
- PR/commit changes

### Step 2: Generate Review Files

Create 5 review files in a `code-review/` directory:

| File | Focus Area |
|------|------------|
| `01-SECURITY-REVIEW.md` | Security vulnerabilities and risks |
| `02-PERFORMANCE-REVIEW.md` | Performance bottlenecks and optimizations |
| `03-BUG-ANALYSIS.md` | Potential bugs and edge cases |
| `04-CODE-QUALITY-REVIEW.md` | Code style, patterns, best practices |
| `05-MAINTAINABILITY-REVIEW.md` | Architecture, documentation, testability |

### Step 3: Use Category-Specific Templates

Each file MUST follow its corresponding template:

| Review File | Template |
|-------------|----------|
| `01-SECURITY-REVIEW.md` | [SECURITY_TEMPLATE.md](SECURITY_TEMPLATE.md) |
| `02-PERFORMANCE-REVIEW.md` | [PERFORMANCE_TEMPLATE.md](PERFORMANCE_TEMPLATE.md) |
| `03-BUG-ANALYSIS.md` | [BUG_TEMPLATE.md](BUG_TEMPLATE.md) |
| `04-CODE-QUALITY-REVIEW.md` | [CODE_QUALITY_TEMPLATE.md](CODE_QUALITY_TEMPLATE.md) |
| `05-MAINTAINABILITY-REVIEW.md` | [MAINTAINABILITY_TEMPLATE.md](MAINTAINABILITY_TEMPLATE.md) |

---

## Review Categories

### 1. Security Review (01-SECURITY-REVIEW.md)

Analyze for:
- **Injection vulnerabilities**: SQL, command, XSS, LDAP
- **Authentication/Authorization**: Broken auth, privilege escalation
- **Data exposure**: Sensitive data leaks, insecure storage
- **Input validation**: Missing or inadequate validation
- **Cryptography**: Weak algorithms, hardcoded secrets
- **OWASP Top 10**: All applicable categories
- **Dependency vulnerabilities**: Known CVEs in dependencies

Severity levels: CRITICAL, HIGH, MEDIUM, LOW, INFO

### 2. Performance Review (02-PERFORMANCE-REVIEW.md)

Analyze for:
- **Algorithm complexity**: O(n²) or worse operations
- **Memory issues**: Leaks, excessive allocation, large objects
- **Database**: N+1 queries, missing indexes, inefficient queries
- **I/O bottlenecks**: Blocking operations, missing caching
- **Concurrency**: Race conditions, deadlocks, thread safety
- **Resource management**: Connection pools, file handles
- **Scalability concerns**: Bottlenecks under load

Impact levels: CRITICAL, HIGH, MEDIUM, LOW

### 3. Bug Analysis (03-BUG-ANALYSIS.md)

Analyze for:
- **Logic errors**: Incorrect conditions, off-by-one errors
- **Null/undefined handling**: Missing null checks, NPE risks
- **Error handling**: Unhandled exceptions, silent failures
- **Edge cases**: Boundary conditions, empty inputs
- **Type errors**: Type mismatches, casting issues
- **State management**: Race conditions, stale state
- **Resource leaks**: Unclosed resources, memory leaks

Likelihood levels: CERTAIN, LIKELY, POSSIBLE, UNLIKELY

### 4. Code Quality Review (04-CODE-QUALITY-REVIEW.md)

Analyze for:
- **Naming conventions**: Clear, descriptive, consistent names
- **Code structure**: Function length, nesting depth, complexity
- **DRY principle**: Code duplication, copy-paste patterns
- **SOLID principles**: Single responsibility, dependency inversion
- **Design patterns**: Appropriate use, anti-patterns
- **Error handling patterns**: Consistent, appropriate
- **Code comments**: Missing, outdated, or excessive

Quality levels: EXCELLENT, GOOD, ACCEPTABLE, NEEDS IMPROVEMENT, POOR

### 5. Maintainability Review (05-MAINTAINABILITY-REVIEW.md)

Analyze for:
- **Architecture**: Module organization, coupling, cohesion
- **Dependencies**: Circular dependencies, tight coupling
- **Documentation**: Missing docs, outdated comments
- **Testability**: Hard-to-test code, missing abstractions
- **Configuration**: Hardcoded values, environment handling
- **Logging/Monitoring**: Observability, debugging support
- **Technical debt**: Workarounds, TODOs, deprecated usage

Maintainability score: A (excellent) to F (critical issues)

---

## Output Format

Each review file follows this structure:

```markdown
# [Category] Review

## Executive Summary
Brief overview with overall rating and key findings count.

## Findings

### [SEVERITY] Finding Title
- **Location**: `file:line`
- **Description**: What the issue is
- **Impact**: Why it matters
- **Recommendation**: How to fix it
- **Code Example**: Before/after if applicable

## Statistics
Summary table of findings by severity.

## Recommendations Priority
Ordered list of what to fix first.
```

See the category-specific templates for complete formatting details.

---

## Execution Instructions

When this skill is invoked:

1. **Ask for scope** if not provided:
   - Which files/directories to review?
   - Recent changes only or full codebase?
   - Any specific concerns to focus on?

2. **Create output directory**:
   ```bash
   mkdir -p code-review
   ```

3. **Analyze code thoroughly**:
   - Read all relevant files
   - Check git history for context
   - Understand the architecture

4. **Generate all 5 review files** using the template

5. **Provide summary** to user with:
   - Total findings per category
   - Critical issues requiring immediate attention
   - Overall code health assessment

---

## Quality Standards

As a senior reviewer, ensure:

- **Be specific**: Reference exact file:line locations
- **Be actionable**: Every finding has a clear recommendation
- **Be fair**: Acknowledge good practices, not just problems
- **Be prioritized**: Critical issues clearly marked
- **Be educational**: Explain WHY something is an issue
- **Be constructive**: Focus on improvement, not criticism

---

## Related Files

### Category-Specific Templates
- [SECURITY_TEMPLATE.md](SECURITY_TEMPLATE.md) - Security review template with OWASP, CWE, CVE tracking
- [PERFORMANCE_TEMPLATE.md](PERFORMANCE_TEMPLATE.md) - Performance review template with complexity analysis
- [BUG_TEMPLATE.md](BUG_TEMPLATE.md) - Bug analysis template with likelihood matrix
- [CODE_QUALITY_TEMPLATE.md](CODE_QUALITY_TEMPLATE.md) - Code quality template with SOLID compliance
- [MAINTAINABILITY_TEMPLATE.md](MAINTAINABILITY_TEMPLATE.md) - Maintainability template with tech debt tracking
