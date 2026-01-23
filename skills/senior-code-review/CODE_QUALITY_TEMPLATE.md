# Code Quality Review Template

Use this template for `04-CODE-QUALITY-REVIEW.md`.

---

```markdown
# Code Quality Review

> **Review Date**: [DATE]
> **Reviewer**: Claude (Senior Code Quality Review)
> **Scope**: [FILES/DIRECTORIES REVIEWED]
> **Commit/Branch**: [IF APPLICABLE]

---

## Executive Summary

| Metric | Value |
|--------|-------|
| **Quality Rating** | [A-F] |
| **Critical Issues** | [COUNT] |
| **Major Issues** | [COUNT] |
| **Minor Issues** | [COUNT] |
| **Suggestions** | [COUNT] |
| **Positive Patterns** | [COUNT] |

### Quality Rating Scale
- **A**: Exemplary code quality - professional, clean, well-structured
- **B**: Good quality - minor issues, follows most best practices
- **C**: Acceptable - room for improvement, some violations
- **D**: Below standard - significant issues, needs refactoring
- **F**: Poor quality - major refactoring required

### Quality Dimensions

| Dimension | Score (1-5) |
|-----------|-------------|
| Readability | [X] |
| Simplicity | [X] |
| Consistency | [X] |
| Naming | [X] |
| Structure | [X] |
| **Average** | **[X.X]** |

### Key Issues
- [Most important quality issues to address]

### Exemplary Code
- [Highlight well-written code patterns found]

---

## SOLID Principles Compliance

| Principle | Status | Notes |
|-----------|--------|-------|
| **S** - Single Responsibility | [GOOD/PARTIAL/POOR] | [Details] |
| **O** - Open/Closed | [GOOD/PARTIAL/POOR] | [Details] |
| **L** - Liskov Substitution | [GOOD/PARTIAL/POOR/N/A] | [Details] |
| **I** - Interface Segregation | [GOOD/PARTIAL/POOR/N/A] | [Details] |
| **D** - Dependency Inversion | [GOOD/PARTIAL/POOR] | [Details] |

---

## Findings

### [MAJOR] QUAL-001: Finding Title

**Location**: `path/to/file.ext:line_number`

**Principle Violated**: [SOLID principle / Clean Code rule / Best practice]

**Issue Description**:
Clear explanation of the quality issue.

**Why It Matters**:
Impact on readability, maintainability, or team productivity.

**Current Code**:
```[language]
// The problematic code
code here
```

**Issues Identified**:
- [Specific issue 1]
- [Specific issue 2]

**Recommended Refactoring**:
Step-by-step approach to improve the code.

**Improved Code**:
```[language]
// The improved version
refactored code here
```

**Benefits of Change**:
- [Benefit 1]
- [Benefit 2]

---

### [MINOR] QUAL-002: Finding Title

[Repeat structure for each finding]

---

## Naming Analysis

### Naming Conventions

| Convention | Status | Examples |
|------------|--------|----------|
| Variables (camelCase/snake_case) | [CONSISTENT/INCONSISTENT] | [Examples] |
| Functions (verbs) | [GOOD/POOR] | [Examples] |
| Classes (PascalCase) | [CONSISTENT/INCONSISTENT] | [Examples] |
| Constants (UPPER_CASE) | [CONSISTENT/INCONSISTENT] | [Examples] |
| Files | [CONSISTENT/INCONSISTENT] | [Examples] |

### Problematic Names

| Location | Current Name | Issue | Suggested Name |
|----------|--------------|-------|----------------|
| `file:line` | `x` | Too short, unclear | `userCount` |
| `file:line` | `data` | Too generic | `customerOrders` |
| `file:line` | `doStuff` | Not descriptive | `processPayment` |

### Naming Best Practices Checklist
- [ ] Names reveal intent
- [ ] Names are pronounceable
- [ ] Names are searchable
- [ ] No abbreviations (except well-known)
- [ ] No type encoding in names
- [ ] Consistent vocabulary

---

## Function Quality

### Function Metrics

| Function | Lines | Parameters | Cyclomatic Complexity | Issues |
|----------|-------|------------|----------------------|--------|
| functionName | 45 | 6 | 12 | Too long, complex |
| anotherFunc | 8 | 2 | 2 | OK |

### Functions Needing Attention

| Location | Issue | Recommendation |
|----------|-------|----------------|
| `file:line` | >30 lines | Split into smaller functions |
| `file:line` | >4 parameters | Use object parameter |
| `file:line` | Complexity >10 | Extract methods, simplify |

### Function Quality Checklist
- [ ] Functions do one thing
- [ ] Functions are small (<30 lines ideal)
- [ ] Few parameters (<4 ideal)
- [ ] No flag arguments
- [ ] No side effects (or clearly documented)
- [ ] Descriptive names (verbs)

---

## Code Duplication (DRY)

### Duplicated Code Found

| Pattern | Occurrences | Locations | Lines Affected |
|---------|-------------|-----------|----------------|
| [Description] | X | file1:line, file2:line | XX lines |

### Duplication Refactoring Recommendations

1. **Pattern**: [Description]
   - Extract to: [function/class/module name]
   - Locations: [List of locations]
   - Estimated reduction: [X lines / X%]

---

## Code Structure

### Nesting Depth Analysis

| Location | Current Depth | Max Recommended | Issue |
|----------|---------------|-----------------|-------|
| `file:line` | 5 | 3 | Too deeply nested |

### Long Methods/Functions

| Location | Lines | Recommended | Action |
|----------|-------|-------------|--------|
| `file:line` | 150 | <50 | Split into smaller units |

### Large Files

| File | Lines | Recommended | Action |
|------|-------|-------------|--------|
| filename.ext | 800 | <400 | Split into modules |

---

## Comments Analysis

### Comment Quality

| Type | Count | Quality |
|------|-------|---------|
| TODO/FIXME | X | [Review needed] |
| Documentation | X | [GOOD/OUTDATED/MISSING] |
| Inline explanatory | X | [HELPFUL/UNNECESSARY] |
| Commented-out code | X | [REMOVE] |

### Comment Issues

| Location | Issue | Recommendation |
|----------|-------|----------------|
| `file:line` | Outdated comment | Update or remove |
| `file:line` | Commented-out code | Remove (use git) |
| `file:line` | States the obvious | Remove |
| `file:line` | Missing explanation | Add comment explaining "why" |

---

## Design Patterns

### Patterns Identified

| Pattern | Location | Implementation |
|---------|----------|----------------|
| [Pattern name] | `file` | [CORRECT/INCORRECT] |

### Anti-Patterns Found

| Anti-Pattern | Location | Issue | Refactoring |
|--------------|----------|-------|-------------|
| God Object | `file` | Class does too much | Split responsibilities |
| Spaghetti Code | `file:line` | Tangled control flow | Extract methods |
| Magic Numbers | `file:line` | Unexplained literals | Use named constants |
| Copy-Paste | Multiple | Code duplication | Extract common code |

---

## Consistency Analysis

### Inconsistencies Found

| Area | Issue | Locations |
|------|-------|-----------|
| Formatting | Mixed styles | file1, file2 |
| Naming | Inconsistent convention | [Examples] |
| Error handling | Different patterns | [Examples] |
| Imports | Different ordering | [Examples] |

### Style Guide Adherence
- [ ] Consistent indentation
- [ ] Consistent brace style
- [ ] Consistent quote usage
- [ ] Consistent semicolon usage
- [ ] Consistent import ordering

---

## Statistics

### Findings by Severity

| Severity | Count | Percentage |
|----------|-------|------------|
| Critical | X | X% |
| Major | X | X% |
| Minor | X | X% |
| Suggestion | X | X% |
| **Total** | **X** | **100%** |

### Findings by Category

| Category | Count |
|----------|-------|
| Naming | X |
| Function Size | X |
| Duplication | X |
| Complexity | X |
| Comments | X |
| Consistency | X |

---

## Refactoring Priority

### High Priority (Readability Blockers)
1. **QUAL-XXX**: [Brief description] - `file:line`
   - Impact: [Team productivity / Bug risk]
   - Effort: [LOW/MEDIUM/HIGH]

### Medium Priority (Code Smells)
1. **QUAL-XXX**: [Brief description] - `file:line`

### Low Priority (Polish)
1. **QUAL-XXX**: [Brief description] - `file:line`

---

## Code Quality Tooling Recommendations

### Linting
- [ ] Configure [linter] with [ruleset]
- [ ] Enable auto-fix on save

### Formatting
- [ ] Set up [formatter] (Prettier, gofmt, etc.)
- [ ] Add pre-commit hook

### Static Analysis
- [ ] Enable [tool] for complexity analysis
- [ ] Set up code coverage requirements

---

## Clean Code Checklist

### Functions
- [ ] Small and focused
- [ ] Single level of abstraction
- [ ] Descriptive names
- [ ] Few arguments
- [ ] No side effects

### Comments
- [ ] Explain "why" not "what"
- [ ] No commented-out code
- [ ] No redundant comments
- [ ] Up-to-date documentation

### Formatting
- [ ] Consistent style
- [ ] Proper indentation
- [ ] Readable line length
- [ ] Logical grouping

### Names
- [ ] Intent-revealing
- [ ] Consistent conventions
- [ ] Pronounceable
- [ ] Searchable

---

*Generated by Senior Code Review - Code Quality Analysis*
```
