# Maintainability Review Template

Use this template for `05-MAINTAINABILITY-REVIEW.md`.

---

```markdown
# Maintainability Review

> **Review Date**: [DATE]
> **Reviewer**: Claude (Senior Maintainability Review)
> **Scope**: [FILES/DIRECTORIES REVIEWED]
> **Commit/Branch**: [IF APPLICABLE]

---

## Executive Summary

| Metric | Value |
|--------|-------|
| **Maintainability Rating** | [A-F] |
| **Critical Issues** | [COUNT] |
| **High Priority Issues** | [COUNT] |
| **Medium Priority Issues** | [COUNT] |
| **Low Priority Issues** | [COUNT] |
| **Technical Debt Items** | [COUNT] |

### Maintainability Rating Scale
- **A**: Highly maintainable - well-architected, documented, testable
- **B**: Good maintainability - minor improvements possible
- **C**: Maintainable with effort - some friction in changes
- **D**: Difficult to maintain - significant technical debt
- **F**: Unmaintainable - major restructuring needed

### Maintainability Index

| Factor | Score (1-10) | Weight | Weighted Score |
|--------|--------------|--------|----------------|
| Modularity | [X] | 20% | [X.X] |
| Documentation | [X] | 15% | [X.X] |
| Testability | [X] | 20% | [X.X] |
| Simplicity | [X] | 15% | [X.X] |
| Coupling | [X] | 15% | [X.X] |
| Cohesion | [X] | 15% | [X.X] |
| **Total** | | **100%** | **[X.X]** |

### Key Concerns
- [Most critical maintainability issues]

### Strengths
- [Well-maintained aspects of the codebase]

---

## Architecture Analysis

### Module Structure

```
[ASCII diagram of module dependencies]
ModuleA --> ModuleB --> ModuleC
    |           |
    v           v
ModuleD     ModuleE
```

### Coupling Analysis

| Module | Afferent (Incoming) | Efferent (Outgoing) | Instability |
|--------|---------------------|---------------------|-------------|
| ModuleA | X | Y | [0.0-1.0] |

**Instability** = Efferent / (Afferent + Efferent)
- 0.0 = Maximally stable (many dependents)
- 1.0 = Maximally unstable (many dependencies)

### Coupling Issues

| Issue | Location | Description | Risk |
|-------|----------|-------------|------|
| Tight Coupling | A ↔ B | Bidirectional dependency | HIGH |
| God Module | ModuleX | Too many dependents | HIGH |
| Circular Dep | A → B → C → A | Circular dependency chain | CRITICAL |

### Cohesion Analysis

| Module | Cohesion Level | Issues |
|--------|----------------|--------|
| ModuleA | HIGH | - |
| ModuleB | LOW | Mixed responsibilities |
| ModuleC | MEDIUM | Some unrelated functions |

---

## Findings

### [CRITICAL] MAINT-001: Finding Title

**Location**: `path/to/file.ext` or module name

**Maintainability Issue**:
Clear explanation of what makes this code hard to maintain.

**Impact on Maintenance**:
- **Change Difficulty**: [How hard is it to modify this code]
- **Risk of Regression**: [Likelihood of breaking something]
- **Onboarding Impact**: [How this affects new developers]

**Current State**:
```[language]
// The problematic code or architecture
code or structure here
```

**Problems Identified**:
- [Specific maintainability issue 1]
- [Specific maintainability issue 2]

**Recommended Refactoring**:
Detailed approach to improve maintainability.

**Target State**:
```[language]
// The improved structure
refactored code or architecture here
```

**Effort Estimate**: [LOW/MEDIUM/HIGH]
**Risk Level**: [LOW/MEDIUM/HIGH]

---

### [HIGH] MAINT-002: Finding Title

[Repeat structure for each finding]

---

## Technical Debt Inventory

### Debt Items

| ID | Type | Location | Description | Interest Rate | Effort |
|----|------|----------|-------------|---------------|--------|
| TD-001 | Architecture | ModuleX | [Description] | HIGH | LARGE |
| TD-002 | Code | `file:line` | [Description] | MEDIUM | SMALL |

**Interest Rate** = How much this debt slows down future development
- HIGH: Significantly impacts every change
- MEDIUM: Impacts some changes
- LOW: Minimal ongoing impact

### Debt by Category

| Category | Count | Total Effort |
|----------|-------|--------------|
| Architecture | X | [person-days] |
| Design | X | [person-days] |
| Code | X | [person-days] |
| Test | X | [person-days] |
| Documentation | X | [person-days] |

### TODO/FIXME/HACK Analysis

| Type | Count | Oldest | Locations |
|------|-------|--------|-----------|
| TODO | X | [date if known] | [files] |
| FIXME | X | [date if known] | [files] |
| HACK | X | [date if known] | [files] |
| XXX | X | [date if known] | [files] |

---

## Documentation Assessment

### Documentation Coverage

| Area | Status | Notes |
|------|--------|-------|
| README | [GOOD/OUTDATED/MISSING] | [Details] |
| API Documentation | [GOOD/OUTDATED/MISSING] | [Details] |
| Architecture Docs | [GOOD/OUTDATED/MISSING] | [Details] |
| Inline Comments | [GOOD/OUTDATED/MISSING] | [Details] |
| Setup Guide | [GOOD/OUTDATED/MISSING] | [Details] |
| Contributing Guide | [GOOD/OUTDATED/MISSING] | [Details] |

### Documentation Gaps

| Area | What's Missing | Priority |
|------|----------------|----------|
| [Area] | [Description] | [HIGH/MED/LOW] |

### Outdated Documentation

| Document | Issue | Last Updated |
|----------|-------|--------------|
| [Doc name] | [What's outdated] | [Date if known] |

---

## Testability Analysis

### Test Coverage Assessment

| Area | Coverage | Quality | Notes |
|------|----------|---------|-------|
| Unit Tests | [X%] | [GOOD/POOR] | [Details] |
| Integration Tests | [X%] | [GOOD/POOR] | [Details] |
| E2E Tests | [X%] | [GOOD/POOR] | [Details] |

### Hard-to-Test Code

| Location | Issue | Refactoring Needed |
|----------|-------|-------------------|
| `file:line` | Tight coupling | Inject dependencies |
| `file:line` | Global state | Use dependency injection |
| `file:line` | Side effects | Extract pure functions |
| `file:line` | Static methods | Make instance methods |

### Missing Test Infrastructure

- [ ] [Missing test utility]
- [ ] [Missing mock/stub]
- [ ] [Missing test fixture]

---

## Configuration Management

### Hardcoded Values

| Location | Value Type | Issue | Recommendation |
|----------|------------|-------|----------------|
| `file:line` | API URL | Hardcoded | Move to config |
| `file:line` | Timeout | Magic number | Use constant |
| `file:line` | Feature flag | Hardcoded | Use config |

### Environment Handling

| Aspect | Status | Notes |
|--------|--------|-------|
| Dev/Prod separation | [GOOD/POOR] | [Details] |
| Secrets management | [GOOD/POOR] | [Details] |
| Feature flags | [PRESENT/MISSING] | [Details] |
| Config validation | [PRESENT/MISSING] | [Details] |

---

## Dependency Management

### Dependency Health

| Dependency | Version | Latest | Status | Risk |
|------------|---------|--------|--------|------|
| package-a | 1.2.3 | 2.0.0 | OUTDATED | MEDIUM |
| package-b | 3.0.0 | 3.0.0 | CURRENT | LOW |
| package-c | 0.9.0 | 1.0.0 | BREAKING CHANGE | HIGH |

### Dependency Concerns

| Issue | Dependencies | Recommendation |
|-------|--------------|----------------|
| Abandoned | [package names] | Find alternatives |
| Security issues | [package names] | Update immediately |
| Too many deps | [count] | Review necessity |
| Duplicate functionality | [packages] | Consolidate |

---

## Observability

### Logging Assessment

| Aspect | Status | Notes |
|--------|--------|-------|
| Log levels | [GOOD/INCONSISTENT] | [Details] |
| Error logging | [COMPREHENSIVE/SPARSE] | [Details] |
| Request tracing | [PRESENT/MISSING] | [Details] |
| Structured logging | [YES/NO] | [Details] |

### Monitoring Gaps

| Area | Current State | Recommendation |
|------|---------------|----------------|
| [Area] | [Current] | [What to add] |

### Debugging Support

| Feature | Status |
|---------|--------|
| Source maps | [YES/NO] |
| Debug mode | [YES/NO] |
| Verbose logging option | [YES/NO] |
| Health checks | [YES/NO] |

---

## Statistics

### Findings by Priority

| Priority | Count | Percentage |
|----------|-------|------------|
| Critical | X | X% |
| High | X | X% |
| Medium | X | X% |
| Low | X | X% |
| **Total** | **X** | **100%** |

### Findings by Category

| Category | Count |
|----------|-------|
| Architecture | X |
| Documentation | X |
| Testability | X |
| Dependencies | X |
| Configuration | X |
| Observability | X |

### Technical Debt Summary

| Metric | Value |
|--------|-------|
| Total Debt Items | X |
| Estimated Effort | [person-days] |
| High Interest Items | X |

---

## Improvement Roadmap

### Immediate (Blocking Development)
1. **MAINT-XXX**: [Brief description]
   - Effort: [X days]
   - Benefit: [Description]

### Short-term (Next Sprint)
1. **MAINT-XXX**: [Brief description]
   - Effort: [X days]

### Medium-term (Next Quarter)
1. **MAINT-XXX**: [Brief description]
   - Effort: [X days]

### Long-term (Technical Debt Paydown)
1. **TD-XXX**: [Brief description]
   - Effort: [X days]

---

## Recommendations

### Quick Wins
- [ ] [Easy improvement with high impact]
- [ ] [Low-effort documentation update]
- [ ] [Simple configuration fix]

### Infrastructure Improvements
- [ ] Set up automated testing
- [ ] Add CI/CD pipeline stages
- [ ] Implement code coverage reporting

### Process Improvements
- [ ] Establish code review guidelines
- [ ] Create architecture decision records (ADRs)
- [ ] Set up documentation review process

### Refactoring Projects
- [ ] [Major refactoring initiative]
- [ ] [Architecture improvement]

---

## Onboarding Assessment

### New Developer Experience

| Aspect | Rating (1-5) | Notes |
|--------|--------------|-------|
| Setup ease | [X] | [Details] |
| Documentation clarity | [X] | [Details] |
| Code navigability | [X] | [Details] |
| Test examples | [X] | [Details] |
| **Overall** | **[X]** | |

### Onboarding Improvements Needed
- [ ] [Improvement 1]
- [ ] [Improvement 2]

---

*Generated by Senior Code Review - Maintainability Analysis*
```
