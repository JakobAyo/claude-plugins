# Security Review Template

Use this template for `01-SECURITY-REVIEW.md`.

---

```markdown
# Security Review

> **Review Date**: [DATE]
> **Reviewer**: Claude (Senior Security Review)
> **Scope**: [FILES/DIRECTORIES REVIEWED]
> **Commit/Branch**: [IF APPLICABLE]

---

## Executive Summary

| Metric | Value |
|--------|-------|
| **Security Rating** | [A-F] |
| **Critical Vulnerabilities** | [COUNT] |
| **High Risk Issues** | [COUNT] |
| **Medium Risk Issues** | [COUNT] |
| **Low Risk Issues** | [COUNT] |
| **Informational** | [COUNT] |

### Security Rating Scale
- **A**: No security issues found - production ready
- **B**: Minor issues only - low risk, fix when convenient
- **C**: Moderate issues - medium risk, fix before release
- **D**: Significant issues - high risk, fix immediately
- **F**: Critical vulnerabilities - DO NOT DEPLOY

### Critical Findings
- [List most severe issues requiring immediate attention]

### Positive Security Practices
- [Acknowledge good security practices found in the code]

---

## OWASP Top 10 Coverage

| Category | Status | Findings |
|----------|--------|----------|
| A01: Broken Access Control | [PASS/FAIL/N/A] | [COUNT] |
| A02: Cryptographic Failures | [PASS/FAIL/N/A] | [COUNT] |
| A03: Injection | [PASS/FAIL/N/A] | [COUNT] |
| A04: Insecure Design | [PASS/FAIL/N/A] | [COUNT] |
| A05: Security Misconfiguration | [PASS/FAIL/N/A] | [COUNT] |
| A06: Vulnerable Components | [PASS/FAIL/N/A] | [COUNT] |
| A07: Auth Failures | [PASS/FAIL/N/A] | [COUNT] |
| A08: Data Integrity Failures | [PASS/FAIL/N/A] | [COUNT] |
| A09: Logging Failures | [PASS/FAIL/N/A] | [COUNT] |
| A10: SSRF | [PASS/FAIL/N/A] | [COUNT] |

---

## Findings

### [CRITICAL] SEC-001: Finding Title

**CWE**: [CWE-XXX - Name]
**OWASP**: [A0X - Category]

**Location**: `path/to/file.ext:line_number`

**Vulnerability Description**:
Detailed explanation of the security vulnerability and why it's dangerous.

**Attack Vector**:
How an attacker could exploit this vulnerability.

**Potential Impact**:
- Confidentiality: [HIGH/MEDIUM/LOW/NONE]
- Integrity: [HIGH/MEDIUM/LOW/NONE]
- Availability: [HIGH/MEDIUM/LOW/NONE]

**Vulnerable Code**:
```[language]
// The vulnerable code
code here
```

**Proof of Concept** (if safe to include):
```
Example attack payload or exploitation steps
```

**Remediation**:
Step-by-step instructions to fix the vulnerability.

**Secure Code Example**:
```[language]
// The secure implementation
fixed code here
```

**References**:
- [CWE Link](https://cwe.mitre.org/data/definitions/XXX.html)
- [OWASP Link](https://owasp.org/...)
- [Additional documentation]

---

### [HIGH] SEC-002: Finding Title

[Repeat structure for each finding]

---

## Dependency Security

### Vulnerable Dependencies Found

| Package | Version | Vulnerability | CVE | Severity | Fix Version |
|---------|---------|---------------|-----|----------|-------------|
| package-name | x.x.x | Description | CVE-XXXX-XXXXX | CRITICAL | x.x.x |

### Dependency Recommendations
1. Update [package] to version [x.x.x] to fix [CVE]
2. ...

---

## Secrets & Sensitive Data

### Hardcoded Secrets Check

| Type | Found | Location |
|------|-------|----------|
| API Keys | [YES/NO] | [file:line if found] |
| Passwords | [YES/NO] | [file:line if found] |
| Private Keys | [YES/NO] | [file:line if found] |
| Connection Strings | [YES/NO] | [file:line if found] |
| Tokens | [YES/NO] | [file:line if found] |

### Data Exposure Risks
- [List any sensitive data that could be exposed]

---

## Authentication & Authorization

### Auth Mechanism Review

| Aspect | Status | Notes |
|--------|--------|-------|
| Password Hashing | [SECURE/WEAK/MISSING] | [Algorithm used] |
| Session Management | [SECURE/WEAK/MISSING] | [Implementation details] |
| Token Validation | [SECURE/WEAK/MISSING] | [JWT/OAuth details] |
| Rate Limiting | [PRESENT/MISSING] | [Limits if present] |
| MFA Support | [PRESENT/MISSING] | [Type if present] |

### Authorization Issues
- [List any privilege escalation or access control issues]

---

## Input Validation & Sanitization

### Injection Points Analyzed

| Input Type | Validated | Sanitized | Parameterized |
|------------|-----------|-----------|---------------|
| SQL Queries | [YES/NO] | [YES/NO] | [YES/NO] |
| Command Execution | [YES/NO] | [YES/NO] | [N/A] |
| File Paths | [YES/NO] | [YES/NO] | [N/A] |
| HTML Output | [YES/NO] | [YES/NO/ESCAPED] | [N/A] |
| URL Parameters | [YES/NO] | [YES/NO] | [N/A] |

---

## Statistics

### Findings by Severity

| Severity | Count | Percentage |
|----------|-------|------------|
| Critical | X | X% |
| High | X | X% |
| Medium | X | X% |
| Low | X | X% |
| Info | X | X% |
| **Total** | **X** | **100%** |

### Findings by OWASP Category

| Category | Count |
|----------|-------|
| A01: Broken Access Control | X |
| A02: Cryptographic Failures | X |
| A03: Injection | X |
| ... | ... |

---

## Remediation Priority

### Immediate (Critical - Fix Now)
1. **SEC-XXX**: [Brief description] - `file:line`
   - Estimated effort: [LOW/MEDIUM/HIGH]

### Urgent (High - Fix Within 24-48h)
1. **SEC-XXX**: [Brief description] - `file:line`

### Short-term (Medium - Fix This Sprint)
1. **SEC-XXX**: [Brief description] - `file:line`

### Long-term (Low - Scheduled Fix)
1. **SEC-XXX**: [Brief description] - `file:line`

---

## Security Recommendations

### Quick Wins
- [ ] [Easy security improvements]

### Architecture Changes
- [ ] [Larger security improvements requiring design changes]

### Security Hardening
- [ ] Enable security headers (CSP, HSTS, etc.)
- [ ] Implement rate limiting
- [ ] Add security logging and monitoring
- [ ] [Other hardening recommendations]

---

## Compliance Notes

| Standard | Relevant Requirements | Status |
|----------|----------------------|--------|
| GDPR | [If applicable] | [COMPLIANT/NON-COMPLIANT/N/A] |
| PCI-DSS | [If applicable] | [COMPLIANT/NON-COMPLIANT/N/A] |
| HIPAA | [If applicable] | [COMPLIANT/NON-COMPLIANT/N/A] |
| SOC 2 | [If applicable] | [COMPLIANT/NON-COMPLIANT/N/A] |

---

*Generated by Senior Code Review - Security Analysis*
```
