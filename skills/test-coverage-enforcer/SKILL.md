---
name: test-coverage-enforcer
description: Enforces test coverage thresholds and prevents coverage reduction. Triggers when running tests, checking coverage, generating coverage reports, or before commits. Keywords - coverage, test coverage, code coverage, coverage report, coverage threshold, pytest-cov, jest coverage, nyc, istanbul, jacoco, go cover, lcov, coverage minimum, coverage percentage.
---

# Test Coverage Enforcer

## Purpose

Maintains and enforces minimum test coverage thresholds across your codebase. Prevents coverage regression and ensures all code paths are adequately tested.

## When to Use

This skill activates when:
- Running test coverage reports
- Committing code changes
- Creating pull requests
- Setting up CI/CD pipelines
- Configuring test frameworks

## Coverage Standards

### Minimum Thresholds

**Overall Coverage:**
- **Statements**: 80% minimum
- **Branches**: 75% minimum
- **Functions**: 80% minimum
- **Lines**: 80% minimum

**By Component Type:**
- **Business Logic**: 90%+ (critical paths)
- **API Endpoints**: 85%+
- **Utilities**: 80%+
- **UI Components**: 70%+ (snapshot/visual tests acceptable)
- **Configuration**: 50%+ (less critical)

### What Counts as Coverage

**Covered:**
- Line executed by at least one test
- Branch (if/else) where both paths are tested
- Function called by at least one test

**Not Covered:**
- Lines never executed in tests
- Unreachable code
- Dead code
- Branches not tested

## Setup by Language

### Python (pytest-cov)

**Install:**
```bash
pip install pytest pytest-cov
```

**Configuration (`pyproject.toml`):**
```toml
[tool.pytest.ini_options]
testpaths = ["tests"]
addopts = [
    "--cov=src",
    "--cov-report=term-missing",
    "--cov-report=html",
    "--cov-fail-under=80",
]

[tool.coverage.run]
source = ["src"]
omit = [
    "*/tests/*",
    "*/test_*.py",
    "*/__pycache__/*",
    "*/venv/*",
]

[tool.coverage.report]
exclude_lines = [
    "pragma: no cover",
    "def __repr__",
    "raise AssertionError",
    "raise NotImplementedError",
    "if __name__ == .__main__.:",
    "if TYPE_CHECKING:",
]
```

**Run:**
```bash
pytest --cov=src --cov-report=term-missing --cov-fail-under=80
```

### JavaScript/TypeScript (Jest)

**Install:**
```bash
npm install --save-dev jest @types/jest
```

**Configuration (`jest.config.js`):**
```javascript
module.exports = {
  collectCoverage: true,
  coverageDirectory: 'coverage',
  coverageReporters: ['text', 'lcov', 'html'],
  coverageThreshold: {
    global: {
      statements: 80,
      branches: 75,
      functions: 80,
      lines: 80,
    },
  },
  collectCoverageFrom: [
    'src/**/*.{js,jsx,ts,tsx}',
    '!src/**/*.d.ts',
    '!src/**/*.test.{js,jsx,ts,tsx}',
    '!src/**/__tests__/**',
  ],
};
```

**Run:**
```bash
npm test -- --coverage
```

### JavaScript/TypeScript (Vitest)

**Configuration (`vitest.config.ts`):**
```typescript
import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    coverage: {
      provider: 'v8',
      reporter: ['text', 'html', 'lcov'],
      statements: 80,
      branches: 75,
      functions: 80,
      lines: 80,
      exclude: [
        '**/*.test.{js,jsx,ts,tsx}',
        '**/*.config.{js,ts}',
        '**/node_modules/**',
      ],
    },
  },
});
```

### Java (JaCoCo with Maven)

**Configuration (`pom.xml`):**
```xml
<plugin>
    <groupId>org.jacoco</groupId>
    <artifactId>jacoco-maven-plugin</artifactId>
    <version>0.8.10</version>
    <executions>
        <execution>
            <goals>
                <goal>prepare-agent</goal>
            </goals>
        </execution>
        <execution>
            <id>report</id>
            <phase>test</phase>
            <goals>
                <goal>report</goal>
            </goals>
        </execution>
        <execution>
            <id>jacoco-check</id>
            <goals>
                <goal>check</goal>
            </goals>
            <configuration>
                <rules>
                    <rule>
                        <element>PACKAGE</element>
                        <limits>
                            <limit>
                                <counter>LINE</counter>
                                <value>COVEREDRATIO</value>
                                <minimum>0.80</minimum>
                            </limit>
                        </limits>
                    </rule>
                </rules>
            </configuration>
        </execution>
    </executions>
</plugin>
```

**Run:**
```bash
mvn clean test jacoco:report
```

### Go (built-in)

**Run:**
```bash
go test -cover ./...

# Detailed coverage report
go test -coverprofile=coverage.out ./...
go tool cover -html=coverage.out
```

**Set threshold in CI:**
```bash
coverage=$(go test -cover ./... | grep -oP '\d+\.\d+(?=%)')
if (( $(echo "$coverage < 80" | bc -l) )); then
    echo "Coverage $coverage% is below threshold 80%"
    exit 1
fi
```

## CI/CD Integration

### GitHub Actions

```yaml
name: Test Coverage
on: [push, pull_request]

jobs:
  coverage:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Set up environment
        uses: actions/setup-node@v3
        with:
          node-version: '18'

      - name: Install dependencies
        run: npm ci

      - name: Run tests with coverage
        run: npm test -- --coverage

      - name: Upload coverage to Codecov
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage/lcov.info
          fail_ci_if_error: true

      - name: Check coverage threshold
        run: |
          coverage=$(jq '.total.lines.pct' coverage/coverage-summary.json)
          if (( $(echo "$coverage < 80" | bc -l) )); then
            echo "Coverage $coverage% is below threshold"
            exit 1
          fi
```

### GitLab CI

```yaml
test:coverage:
  stage: test
  script:
    - npm ci
    - npm test -- --coverage
  coverage: '/Lines\s*:\s*(\d+\.\d+)%/'
  artifacts:
    reports:
      coverage_report:
        coverage_format: cobertura
        path: coverage/cobertura-coverage.xml
```

## Coverage Reports

### HTML Report (Human-Readable)
- Shows line-by-line what's covered
- Highlights uncovered lines in red
- Navigate by file/directory

**Generate:**
```bash
# Python
pytest --cov=src --cov-report=html
open htmlcov/index.html

# JavaScript
npm test -- --coverage
open coverage/index.html

# Go
go test -coverprofile=coverage.out ./...
go tool cover -html=coverage.out
```

### Terminal Report (Quick Check)
```bash
# Python
pytest --cov=src --cov-report=term-missing

# JavaScript
npm test -- --coverage --coverageReporters=text

# Go
go test -cover ./...
```

### LCOV (CI Integration)
- Machine-readable format
- Used by Codecov, Coveralls, SonarQube
- Can be converted to other formats

## Excluding Code from Coverage

### Python
```python
def debug_only_function():  # pragma: no cover
    """This function is only for debugging"""
    print("Debug info")

if __name__ == "__main__":  # pragma: no cover
    main()
```

### JavaScript
```javascript
/* istanbul ignore next */
function debugOnly() {
  console.log("Debug info");
}

// Or ignore entire file
/* istanbul ignore file */
```

### Java
```java
// JaCoCo looks for @Generated annotation
@Generated
public String toString() {
    return "Generated code";
}
```

## Common Coverage Issues

### Issue 1: Low Branch Coverage

**Problem:**
```typescript
function divide(a: number, b: number): number {
  if (b === 0) {
    throw new Error("Division by zero");
  }
  return a / b;
}

// Test only happy path
test('divides two numbers', () => {
  expect(divide(10, 2)).toBe(5);
});
```

**Solution:**
```typescript
// Test both branches
describe('divide', () => {
  it('divides two numbers', () => {
    expect(divide(10, 2)).toBe(5);
  });

  it('throws error on division by zero', () => {
    expect(() => divide(10, 0)).toThrow('Division by zero');
  });
});
```

### Issue 2: Untested Error Handlers

**Problem:**
```python
try:
    risky_operation()
except Exception as e:
    log_error(e)  # Uncovered
    raise
```

**Solution:**
```python
def test_error_handling():
    with pytest.raises(SomeException):
        # This will hit the except block
        risky_operation_that_fails()

    # Verify error was logged
    assert "error" in captured_logs
```

### Issue 3: Async Code Not Awaited

**Problem:**
```javascript
// Test doesn't wait for promise
test('fetches data', () => {
  fetchData();  // Promise not awaited
  expect(data).toBeDefined();  // Runs before fetch completes
});
```

**Solution:**
```javascript
test('fetches data', async () => {
  await fetchData();
  expect(data).toBeDefined();
});
```

## Pre-commit Hook Integration

**`.git/hooks/pre-commit`:**
```bash
#!/bin/bash

echo "Running tests with coverage check..."

# Run tests with coverage
npm test -- --coverage --watchAll=false

# Extract coverage percentage
coverage=$(jq '.total.lines.pct' coverage/coverage-summary.json)

# Check threshold
if (( $(echo "$coverage < 80" | bc -l) )); then
    echo "❌ Coverage ${coverage}% is below threshold 80%"
    echo "Please add more tests before committing"
    exit 1
fi

echo "✅ Coverage ${coverage}% meets threshold"
exit 0
```

## Coverage Badges

Add to README for visibility:

**Codecov:**
```markdown
[![codecov](https://codecov.io/gh/username/repo/branch/main/graph/badge.svg)](https://codecov.io/gh/username/repo)
```

**Coveralls:**
```markdown
[![Coverage Status](https://coveralls.io/repos/github/username/repo/badge.svg?branch=main)](https://coveralls.io/github/username/repo?branch=main)
```

## Best Practices

1. **Track Coverage Over Time**
   - Set up trend monitoring
   - Prevent coverage regressions
   - Celebrate coverage improvements

2. **Focus on Meaningful Coverage**
   - Don't chase 100% for vanity
   - Test critical paths thoroughly
   - Less critical code can have lower coverage

3. **Review Uncovered Lines**
   - Use HTML reports to find gaps
   - Prioritize uncovered error handlers
   - Add tests for business logic first

4. **Make Coverage Visible**
   - Add badge to README
   - Display in PR comments
   - Include in CI/CD status checks

5. **Don't Game the Metrics**
   - Avoid useless tests just for coverage
   - Test behavior, not implementation
   - Quality > Quantity

## Troubleshooting

**Coverage report shows 0%:**
- Check coverage tool is installed
- Verify source paths in config
- Ensure tests are actually running

**Coverage lower than expected:**
- Check if all test files are being discovered
- Verify file patterns in config
- Look for untested branches/error handlers

**CI fails but local passes:**
- Check CI uses same thresholds
- Verify same files are being covered
- Compare coverage reports

## Quick Reference

**Check Current Coverage:**
```bash
# Python
pytest --cov=src --cov-report=term

# JavaScript
npm test -- --coverage --coverageReporters=text

# Go
go test -cover ./...
```

**Generate HTML Report:**
```bash
# Python
pytest --cov=src --cov-report=html && open htmlcov/index.html

# JavaScript
npm test -- --coverage && open coverage/index.html

# Go
go test -coverprofile=coverage.out ./... && go tool cover -html=coverage.out
```

**Fail on Low Coverage:**
```bash
# Python
pytest --cov=src --cov-fail-under=80

# JavaScript (configured in jest.config.js)
npm test -- --coverage

# Go (manual check)
./check-coverage.sh 80
```

---

**Enforcement Level**: SUGGEST (Advisory)
**Priority**: HIGH
**Integration**: CI/CD, Pre-commit hooks
**Tools**: pytest-cov, Jest, JaCoCo, Go coverage
