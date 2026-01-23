# Bug Analysis Template

Use this template for `03-BUG-ANALYSIS.md`.

---

```markdown
# Bug Analysis

> **Review Date**: [DATE]
> **Reviewer**: Claude (Senior Bug Analysis)
> **Scope**: [FILES/DIRECTORIES REVIEWED]
> **Commit/Branch**: [IF APPLICABLE]

---

## Executive Summary

| Metric | Value |
|--------|-------|
| **Bug Risk Rating** | [A-F] |
| **Certain Bugs** | [COUNT] |
| **Likely Bugs** | [COUNT] |
| **Possible Bugs** | [COUNT] |
| **Edge Cases** | [COUNT] |
| **Code Smells** | [COUNT] |

### Bug Risk Rating Scale
- **A**: No bugs found - high confidence in correctness
- **B**: Minor edge cases only - low bug risk
- **C**: Some bugs found - mostly non-critical
- **D**: Multiple bugs - some serious issues
- **F**: Critical bugs - system reliability at risk

### Critical Bugs
- [List definite bugs requiring immediate attention]

### Code Strengths
- [Acknowledge robust error handling and defensive coding found]

---

## Bug Likelihood Matrix

Use this matrix to classify findings:

| | **High Impact** | **Medium Impact** | **Low Impact** |
|---|-----------------|-------------------|----------------|
| **Certain** | CRITICAL | HIGH | MEDIUM |
| **Likely** | HIGH | MEDIUM | LOW |
| **Possible** | MEDIUM | LOW | LOW |
| **Unlikely** | LOW | INFO | INFO |

---

## Findings

### [CRITICAL] BUG-001: Finding Title

**Location**: `path/to/file.ext:line_number`

**Likelihood**: CERTAIN / LIKELY / POSSIBLE / UNLIKELY
**Impact**: HIGH / MEDIUM / LOW

**Bug Description**:
Clear explanation of what the bug is and why it will cause problems.

**Root Cause**:
Technical explanation of why this bug exists.

**Trigger Condition**:
Specific conditions that cause this bug to manifest.

**Buggy Code**:
```[language]
// The buggy code
code here
```

**Reproduction Steps**:
1. [Step 1]
2. [Step 2]
3. [Expected vs Actual behavior]

**Expected Behavior**:
What should happen.

**Actual Behavior**:
What actually happens (or would happen).

**Impact Analysis**:
- **User Impact**: [Description]
- **Data Impact**: [Description]
- **System Impact**: [Description]

**Fix**:
```[language]
// The corrected code
fixed code here
```

**Test Case to Add**:
```[language]
// Test that would catch this bug
test code here
```

---

### [HIGH] BUG-002: Finding Title

[Repeat structure for each finding]

---

## Bug Categories

### Logic Errors

| ID | Location | Description | Likelihood |
|----|----------|-------------|------------|
| BUG-XXX | `file:line` | [Brief description] | CERTAIN |

### Null/Undefined Handling

| ID | Location | Variable | Risk |
|----|----------|----------|------|
| BUG-XXX | `file:line` | [var name] | NPE possible |

### Off-by-One Errors

| ID | Location | Type | Description |
|----|----------|------|-------------|
| BUG-XXX | `file:line` | Array index | [Description] |

### Boundary Conditions

| ID | Location | Boundary | Issue |
|----|----------|----------|-------|
| BUG-XXX | `file:line` | Empty array | Not handled |
| BUG-XXX | `file:line` | Max int | Overflow |

### Type Errors

| ID | Location | Expected | Actual | Risk |
|----|----------|----------|--------|------|
| BUG-XXX | `file:line` | number | string | Runtime error |

### State Management Issues

| ID | Location | Issue | Trigger |
|----|----------|-------|---------|
| BUG-XXX | `file:line` | Stale state | [Condition] |
| BUG-XXX | `file:line` | Race condition | [Condition] |

---

## Error Handling Analysis

### Unhandled Exceptions

| Location | Exception Type | Consequence |
|----------|----------------|-------------|
| `file:line` | [Exception] | [What happens] |

### Silent Failures

| Location | Operation | Issue |
|----------|-----------|-------|
| `file:line` | [Operation] | Error swallowed silently |

### Missing Error Paths

| Location | Scenario | Missing Handler |
|----------|----------|-----------------|
| `file:line` | [Scenario] | No catch/error handler |

### Error Handling Recommendations
1. [Specific error handling improvements]

---

## Edge Cases Not Handled

### Input Edge Cases

| Input Type | Edge Case | Location | Status |
|------------|-----------|----------|--------|
| String | Empty string | `file:line` | NOT HANDLED |
| String | Very long string | `file:line` | NOT HANDLED |
| Array | Empty array | `file:line` | NOT HANDLED |
| Array | Single element | `file:line` | HANDLED |
| Number | Zero | `file:line` | NOT HANDLED |
| Number | Negative | `file:line` | NOT HANDLED |
| Number | MAX_VALUE | `file:line` | NOT HANDLED |
| Object | Null | `file:line` | NOT HANDLED |
| Object | Missing properties | `file:line` | NOT HANDLED |

### Concurrency Edge Cases

| Scenario | Location | Status |
|----------|----------|--------|
| Simultaneous updates | `file:line` | NOT HANDLED |
| Request timeout | `file:line` | NOT HANDLED |
| Connection drop | `file:line` | HANDLED |

---

## Resource Leak Analysis

### Potential Resource Leaks

| Resource | Location | Leak Scenario |
|----------|----------|---------------|
| File handle | `file:line` | Error before close |
| DB connection | `file:line` | Exception in middle |
| Event listener | `file:line` | Never removed |
| Timer/Interval | `file:line` | Never cleared |

---

## Statistics

### Findings by Likelihood

| Likelihood | Count | Percentage |
|------------|-------|------------|
| Certain | X | X% |
| Likely | X | X% |
| Possible | X | X% |
| Unlikely | X | X% |
| **Total** | **X** | **100%** |

### Findings by Category

| Category | Count |
|----------|-------|
| Logic Errors | X |
| Null Handling | X |
| Boundary Conditions | X |
| Error Handling | X |
| Type Errors | X |
| State Issues | X |

### Findings by File

| File | Critical | High | Medium | Low | Total |
|------|----------|------|--------|-----|-------|
| file1.ext | X | X | X | X | X |

---

## Fix Priority

### Immediate (Certain Bugs)
1. **BUG-XXX**: [Brief description] - `file:line`
   - Impact: [User/Data/System impact]
   - Effort: [LOW/MEDIUM/HIGH]

### Soon (Likely Bugs)
1. **BUG-XXX**: [Brief description] - `file:line`

### Scheduled (Possible Bugs)
1. **BUG-XXX**: [Brief description] - `file:line`

### Backlog (Edge Cases)
1. **BUG-XXX**: [Brief description] - `file:line`

---

## Testing Gaps

### Missing Test Coverage

| Area | Current Coverage | Risk |
|------|------------------|------|
| [Function/Module] | [None/Partial/Good] | [HIGH/MED/LOW] |

### Recommended Test Cases

```[language]
// Test cases that should be added
describe('Function', () => {
  it('should handle empty input', () => { ... });
  it('should handle null values', () => { ... });
  it('should handle boundary values', () => { ... });
});
```

### Integration Test Gaps
- [ ] [Missing integration test scenario]
- [ ] [Missing end-to-end test]

---

## Defensive Coding Recommendations

### Input Validation to Add
- [ ] Validate [input] at `file:line`
- [ ] Add null check for [variable] at `file:line`

### Guard Clauses to Add
- [ ] Early return for [condition] at `file:line`

### Assertions to Add
- [ ] Assert [condition] at `file:line`

---

*Generated by Senior Code Review - Bug Analysis*
```
