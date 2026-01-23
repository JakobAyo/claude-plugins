# Performance Review Template

Use this template for `02-PERFORMANCE-REVIEW.md`.

---

```markdown
# Performance Review

> **Review Date**: [DATE]
> **Reviewer**: Claude (Senior Performance Review)
> **Scope**: [FILES/DIRECTORIES REVIEWED]
> **Commit/Branch**: [IF APPLICABLE]

---

## Executive Summary

| Metric | Value |
|--------|-------|
| **Performance Rating** | [A-F] |
| **Critical Bottlenecks** | [COUNT] |
| **High Impact Issues** | [COUNT] |
| **Medium Impact Issues** | [COUNT] |
| **Low Impact Issues** | [COUNT] |
| **Optimization Opportunities** | [COUNT] |

### Performance Rating Scale
- **A**: Optimal performance - well-optimized code
- **B**: Good performance - minor improvements possible
- **C**: Acceptable - notable optimizations needed
- **D**: Performance issues affecting user experience
- **F**: Severe bottlenecks - system stability at risk

### Critical Bottlenecks
- [List most severe performance issues]

### Performance Strengths
- [Acknowledge well-optimized code patterns found]

---

## Complexity Analysis

### Algorithm Complexity Summary

| Function/Method | Time Complexity | Space Complexity | Data Size Concern |
|-----------------|-----------------|------------------|-------------------|
| functionName() | O(n²) | O(n) | [YES/NO] |
| anotherFunc() | O(n log n) | O(1) | [NO] |

### High Complexity Hotspots

| Location | Current | Recommended | Improvement |
|----------|---------|-------------|-------------|
| `file:line` | O(n²) | O(n log n) | [Description] |

---

## Findings

### [CRITICAL] PERF-001: Finding Title

**Location**: `path/to/file.ext:line_number`

**Performance Issue**:
Detailed explanation of the performance problem.

**Impact Analysis**:
- **Latency Impact**: [Xms added per request/operation]
- **Throughput Impact**: [X% reduction in capacity]
- **Resource Impact**: [CPU/Memory/I/O affected]
- **Scale Factor**: [How it degrades with data size]

**Current Complexity**: O(n²)
**Target Complexity**: O(n) or O(n log n)

**Problematic Code**:
```[language]
// The slow code
code here
```

**Performance Profile**:
| Input Size | Current Time | Expected Time |
|------------|--------------|---------------|
| 100 | Xms | Xms |
| 1,000 | Xms | Xms |
| 10,000 | Xms | Xms |

**Optimization Strategy**:
Step-by-step approach to fix the issue.

**Optimized Code**:
```[language]
// The optimized implementation
fixed code here
```

**Expected Improvement**: [X% faster / Xms saved]

---

### [HIGH] PERF-002: Finding Title

[Repeat structure for each finding]

---

## Database Performance

### Query Analysis

| Query Location | Type | Issues Found |
|----------------|------|--------------|
| `file:line` | SELECT | N+1, Missing Index |
| `file:line` | UPDATE | Full Table Scan |

### N+1 Query Problems

| Location | Entity | Queries Generated | Fix |
|----------|--------|-------------------|-----|
| `file:line` | User.posts | N+1 | Eager loading |

### Missing Indexes

| Table | Column(s) | Query Pattern | Priority |
|-------|-----------|---------------|----------|
| users | email | WHERE email = ? | HIGH |
| orders | user_id, created_at | WHERE + ORDER BY | MEDIUM |

### Query Optimization Recommendations
1. [Specific query optimization suggestions]

---

## Memory Analysis

### Memory Concerns

| Location | Issue | Estimated Impact |
|----------|-------|------------------|
| `file:line` | Large object allocation | [X MB per request] |
| `file:line` | Potential memory leak | [Growing over time] |

### Object Lifecycle Issues
- [Objects held longer than necessary]
- [Missing cleanup/disposal]
- [Circular references]

### Memory Optimization Recommendations
1. [Specific memory optimization suggestions]

---

## I/O Performance

### Blocking Operations

| Location | Operation Type | Impact |
|----------|----------------|--------|
| `file:line` | Sync file read | Blocks event loop |
| `file:line` | Sync HTTP call | Blocks thread |

### Missing Caching Opportunities

| Data | Access Pattern | Cache Recommendation |
|------|----------------|---------------------|
| [Data type] | [Frequency] | [Cache strategy] |

### I/O Optimization Recommendations
1. [Specific I/O optimization suggestions]

---

## Concurrency & Threading

### Thread Safety Issues

| Location | Issue | Risk Level |
|----------|-------|------------|
| `file:line` | Race condition | HIGH |
| `file:line` | Deadlock potential | CRITICAL |

### Concurrency Patterns Review

| Pattern | Implementation | Status |
|---------|----------------|--------|
| Connection Pooling | [Present/Missing] | [OK/ISSUE] |
| Thread Pooling | [Present/Missing] | [OK/ISSUE] |
| Async/Await Usage | [Correct/Incorrect] | [OK/ISSUE] |

---

## Resource Management

### Resource Leaks

| Resource Type | Location | Issue |
|---------------|----------|-------|
| DB Connection | `file:line` | Not closed in error path |
| File Handle | `file:line` | Missing finally/defer |
| HTTP Client | `file:line` | Connection not released |

### Resource Pool Configuration

| Pool | Current Size | Recommended | Notes |
|------|--------------|-------------|-------|
| DB Connections | [X] | [Y] | [Reasoning] |
| HTTP Clients | [X] | [Y] | [Reasoning] |

---

## Scalability Assessment

### Horizontal Scaling Readiness

| Aspect | Status | Notes |
|--------|--------|-------|
| Stateless Design | [YES/NO] | [Issues if NO] |
| Session Handling | [READY/NOT READY] | [Details] |
| Cache Strategy | [READY/NOT READY] | [Details] |
| Database Scaling | [READY/NOT READY] | [Details] |

### Vertical Scaling Limits

| Resource | Current Usage | Scaling Limit | Bottleneck Risk |
|----------|---------------|---------------|-----------------|
| CPU | [X%] | [Description] | [LOW/MED/HIGH] |
| Memory | [X GB] | [Description] | [LOW/MED/HIGH] |
| I/O | [X ops/s] | [Description] | [LOW/MED/HIGH] |

---

## Statistics

### Findings by Impact

| Impact Level | Count | Percentage |
|--------------|-------|------------|
| Critical | X | X% |
| High | X | X% |
| Medium | X | X% |
| Low | X | X% |
| **Total** | **X** | **100%** |

### Findings by Category

| Category | Count |
|----------|-------|
| Algorithm Complexity | X |
| Database | X |
| Memory | X |
| I/O | X |
| Concurrency | X |

---

## Optimization Priority

### Immediate (Critical - Blocking Issues)
1. **PERF-XXX**: [Brief description] - `file:line`
   - Expected improvement: [X% / Xms]
   - Effort: [LOW/MEDIUM/HIGH]

### High Impact (Quick Wins)
1. **PERF-XXX**: [Brief description] - `file:line`
   - Expected improvement: [X% / Xms]

### Medium Impact (Scheduled Work)
1. **PERF-XXX**: [Brief description] - `file:line`

### Nice to Have (Future Optimization)
1. **PERF-XXX**: [Brief description] - `file:line`

---

## Performance Testing Recommendations

### Suggested Benchmarks
- [ ] [Specific benchmark to add]
- [ ] [Load test scenario]
- [ ] [Stress test scenario]

### Monitoring Recommendations
- [ ] Add metrics for [specific operation]
- [ ] Set up alerting for [threshold]
- [ ] Track [specific KPI]

---

## Tools & Profiling Suggestions

| Tool | Purpose | Priority |
|------|---------|----------|
| [Profiler name] | CPU profiling | HIGH |
| [APM tool] | Request tracing | MEDIUM |
| [Memory tool] | Memory analysis | MEDIUM |

---

*Generated by Senior Code Review - Performance Analysis*
```
