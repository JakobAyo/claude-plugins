---
name: qa-guardian
description: Quality assurance enforcement for code changes. Triggers when writing, editing, or modifying code files to ensure tests exist, test coverage is maintained, and quality standards are met. Keywords - test, testing, quality assurance, QA, code coverage, unit test, integration test, TDD, test-driven development, modify code, edit code, write code, refactor, bug fix, feature implementation.
---

# QA Guardian

## Purpose

Enforces quality assurance standards before code changes are committed. This skill ensures that:
- Tests exist for code being modified
- Test coverage thresholds are maintained
- Code changes follow testing best practices
- Quality gates are enforced before commits

## When to Use

This skill automatically activates when:
- Editing or writing source code files
- Modifying existing functions or classes
- Adding new features or functionality
- Refactoring code
- Fixing bugs

## Core Principles

### 1. Test-First Development
- Write tests before or alongside production code
- Never commit production code without corresponding tests
- Maintain minimum test coverage thresholds

### 2. Test Location Standards

**Python Projects:**
```
src/
  module/
    __init__.py
    feature.py          # Production code
tests/
  test_feature.py       # Tests mirror src structure
```

**JavaScript/TypeScript Projects:**
```
src/
  module/
    feature.ts          # Production code
    feature.test.ts     # Tests colocated (preferred)
OR
tests/
  module/
    feature.test.ts     # Tests mirror src structure
```

**Java Projects:**
```
src/main/java/
  com/package/Feature.java
src/test/java/
  com/package/FeatureTest.java
```

**Go Projects:**
```
pkg/
  feature/
    feature.go
    feature_test.go     # Tests colocated
```

### 3. Test Coverage Requirements

**Minimum Coverage by Test Type:**
- Unit Tests: 80% line coverage minimum
- Integration Tests: Cover all API endpoints and service integrations
- E2E Tests: Cover critical user journeys

**What Must Be Tested:**
- All public functions and methods
- All exported functions/classes
- All API endpoints
- Error handling and edge cases
- Business logic and calculations

**What Can Skip Tests:**
- Simple getters/setters
- Type definitions and interfaces
- Configuration files
- Build scripts

### 4. Test Quality Standards

**Good Tests Are:**
- **Independent** - Can run in any order
- **Fast** - Unit tests run in milliseconds
- **Repeatable** - Same result every time
- **Self-validating** - Pass or fail, no manual inspection
- **Timely** - Written before or with production code

**Test Structure (AAA Pattern):**
```python
def test_user_registration():
    # Arrange - Set up test data
    user_data = {"email": "test@example.com", "password": "secure123"}

    # Act - Execute the code under test
    result = register_user(user_data)

    # Assert - Verify the outcome
    assert result.success is True
    assert result.user.email == "test@example.com"
```

## When Tests Are Required

### ✅ MUST Have Tests
- New feature implementations
- Bug fixes (test should reproduce the bug)
- Refactoring existing code
- API endpoint changes
- Database schema changes
- Business logic modifications
- Security-related code
- Payment or financial calculations

### ⚠️ CONSIDER Tests
- UI component changes (snapshot/visual tests)
- Configuration updates
- Documentation changes
- Simple text changes

### ❌ NO Tests Required
- README updates
- Comments or documentation-only changes
- Dependency version bumps (unless breaking)
- Build configuration (unless complex logic)

## Common Patterns

### Pattern 1: Adding a New Function

**Before:**
```typescript
// src/utils/validation.ts
export function validateEmail(email: string): boolean {
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return regex.test(email);
}
```

**Required Test:**
```typescript
// src/utils/validation.test.ts
import { validateEmail } from './validation';

describe('validateEmail', () => {
  it('accepts valid email addresses', () => {
    expect(validateEmail('user@example.com')).toBe(true);
  });

  it('rejects invalid email addresses', () => {
    expect(validateEmail('invalid-email')).toBe(false);
    expect(validateEmail('@example.com')).toBe(false);
    expect(validateEmail('user@')).toBe(false);
  });

  it('handles edge cases', () => {
    expect(validateEmail('')).toBe(false);
    expect(validateEmail('user+tag@example.co.uk')).toBe(true);
  });
});
```

### Pattern 2: Modifying Existing Function

**When editing existing code:**
1. First, read the existing test file
2. Verify test coverage for the function
3. Add tests for new behavior or edge cases
4. Update tests if changing function signature
5. Run tests to ensure nothing broke

### Pattern 3: Bug Fix

**Bug fixes ALWAYS need tests:**
```typescript
// 1. Write test that reproduces the bug (should fail)
it('handles null values without crashing', () => {
  expect(() => processData(null)).not.toThrow();
});

// 2. Fix the bug in production code
export function processData(data: any) {
  if (data === null) return null;  // Fix
  // ... rest of function
}

// 3. Test should now pass
```

## Testing Frameworks by Language

### Python
```bash
# pytest (recommended)
pip install pytest pytest-cov

# Run tests with coverage
pytest --cov=src --cov-report=term-missing
```

### JavaScript/TypeScript
```bash
# Jest (React, Node.js)
npm install --save-dev jest @types/jest

# Vitest (Modern, faster)
npm install --save-dev vitest

# Run tests
npm test
```

### Java
```xml
<!-- Maven - JUnit 5 -->
<dependency>
    <groupId>org.junit.jupiter</groupId>
    <artifactId>junit-jupiter</artifactId>
    <version>5.10.0</version>
    <scope>test</scope>
</dependency>
```

### Go
```bash
# Built-in testing
go test ./...

# With coverage
go test -cover ./...
```

## Integration with CI/CD

Tests should run automatically:
- On every commit (pre-commit hook)
- On pull request creation
- Before merging to main branch
- Before deployment

**Example GitHub Actions:**
```yaml
name: Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run tests
        run: npm test
      - name: Check coverage
        run: npm run coverage -- --threshold 80
```

## Bypass Conditions

You can skip test enforcement if:

1. **File is marked as verified:**
```typescript
// @skip-test-verification
// This file has been manually verified and doesn't need tests
```

2. **Emergency hotfix** (use sparingly):
```bash
export SKIP_QA_GUARDIAN=true
# Make your changes
unset SKIP_QA_GUARDIAN
```

3. **Non-production code:**
- Prototype/spike code
- Demo/example code
- Scripts in `/scripts` or `/tools` directories

## Quick Checklist

Before committing code, verify:
- [ ] Tests exist for new/modified code
- [ ] Tests follow AAA pattern (Arrange, Act, Assert)
- [ ] Tests are independent and can run in any order
- [ ] Edge cases and error conditions are tested
- [ ] Tests run successfully locally
- [ ] Code coverage meets minimum threshold (80%)
- [ ] Integration tests cover API changes
- [ ] No commented-out test code

## Common Questions

**Q: Do I need tests for simple getters/setters?**
A: No, unless they contain logic beyond simple property access.

**Q: What if I'm just experimenting?**
A: Use feature branches or add `@skip-test-verification` comment. Remove before merging.

**Q: How do I test private methods?**
A: Test them through public methods. If that's difficult, consider if the method should be public or if your class needs refactoring.

**Q: What about legacy code without tests?**
A: When modifying legacy code, add tests for the parts you change. Don't feel obligated to test the entire legacy codebase.

**Q: How do I test async code?**
A: Use your framework's async testing utilities (async/await in Jest, pytest-asyncio, etc.)

## Related Skills

- **test-generator** - Get help generating test templates
- **test-coverage-enforcer** - Enforce coverage thresholds
- **security-scanner** - Security-focused testing
- **code-quality-checker** - Overall code quality standards

## Additional Resources

- [Test-Driven Development by Example](https://www.amazon.com/Test-Driven-Development-Kent-Beck/dp/0321146530)
- [Testing JavaScript Applications](https://testingjavascript.com/)
- [Python Testing with pytest](https://pragprog.com/titles/bopytest/python-testing-with-pytest/)
- [Go Testing Best Practices](https://go.dev/doc/tutorial/add-a-test)

---

**Enforcement Level**: BLOCK (Guardrail)
**Priority**: CRITICAL
**Session Aware**: Yes (won't nag repeatedly in same session)
**Skip Markers**: `@skip-test-verification`, `SKIP_QA_GUARDIAN=true`
