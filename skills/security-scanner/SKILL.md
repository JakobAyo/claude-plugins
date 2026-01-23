---
name: security-scanner
description: Security vulnerability detection and prevention for code changes. Triggers when handling authentication, authorization, user input, database queries, API calls, file operations, encryption, secrets management, dependencies. Keywords - security, vulnerability, XSS, SQL injection, CSRF, authentication, authorization, secrets, credentials, password, token, API key, encryption, sanitize, validate input, OWASP, CVE, security scan, dependency scan.
---

# Security Scanner

## Purpose

Identifies and prevents common security vulnerabilities in code before they reach production. Provides guidance on secure coding practices and automated security scanning.

## When to Use

This skill activates when:
- Handling user input or form data
- Working with authentication/authorization
- Making database queries
- Processing file uploads
- Implementing API endpoints
- Managing secrets or credentials
- Working with dependencies

## OWASP Top 10 Security Risks

### 1. Injection Attacks

**SQL Injection:**
```python
# ❌ VULNERABLE
query = f"SELECT * FROM users WHERE username = '{username}'"
db.execute(query)

# ✅ SECURE - Use parameterized queries
query = "SELECT * FROM users WHERE username = ?"
db.execute(query, (username,))
```

```javascript
// ❌ VULNERABLE
const query = `SELECT * FROM users WHERE id = ${userId}`;

// ✅ SECURE - Use parameterized queries or ORM
const query = 'SELECT * FROM users WHERE id = ?';
db.query(query, [userId]);

// Better: Use an ORM
const user = await User.findById(userId);
```

**Command Injection:**
```python
# ❌ VULNERABLE
os.system(f"ping {user_input}")

# ✅ SECURE
import subprocess
subprocess.run(["ping", "-c", "1", user_input], check=True)
```

### 2. Broken Authentication

**Weak Password Policies:**
```python
# ❌ VULNERABLE
if len(password) < 6:
    return "Password too short"

# ✅ SECURE
import re

def validate_password(password):
    if len(password) < 12:
        return False, "Minimum 12 characters required"
    if not re.search(r"[A-Z]", password):
        return False, "Must contain uppercase letter"
    if not re.search(r"[a-z]", password):
        return False, "Must contain lowercase letter"
    if not re.search(r"\d", password):
        return False, "Must contain digit"
    if not re.search(r"[!@#$%^&*]", password):
        return False, "Must contain special character"
    return True, "Password valid"
```

**Secure Password Storage:**
```python
# ❌ VULNERABLE
password = hashlib.md5(user_password.encode()).hexdigest()

# ✅ SECURE - Use bcrypt, argon2, or scrypt
import bcrypt

hashed = bcrypt.hashpw(password.encode(), bcrypt.gensalt())
# Verify
if bcrypt.checkpw(user_input.encode(), hashed):
    print("Password correct")
```

```javascript
// ✅ SECURE - bcrypt
const bcrypt = require('bcrypt');
const saltRounds = 12;

const hashedPassword = await bcrypt.hash(password, saltRounds);
// Verify
const match = await bcrypt.compare(inputPassword, hashedPassword);
```

### 3. Sensitive Data Exposure

**Never Hardcode Secrets:**
```python
# ❌ VULNERABLE
API_KEY = "sk_live_51H7x8yH..."
DATABASE_URL = "postgresql://user:password@localhost/db"

# ✅ SECURE - Use environment variables
import os
API_KEY = os.environ.get("API_KEY")
DATABASE_URL = os.environ.get("DATABASE_URL")

# ✅ EVEN BETTER - Use secrets management
from azure.keyvault.secrets import SecretClient
API_KEY = secret_client.get_secret("api-key").value
```

**Secure Configuration Files:**
```bash
# .gitignore
.env
.env.local
secrets.json
credentials.json
*.key
*.pem
config/production.json
```

### 4. XML External Entities (XXE)

```python
# ❌ VULNERABLE
import xml.etree.ElementTree as ET
tree = ET.parse(user_file)

# ✅ SECURE
import defusedxml.ElementTree as ET
tree = ET.parse(user_file)
```

### 5. Broken Access Control

**Insecure Direct Object Reference (IDOR):**
```javascript
// ❌ VULNERABLE
app.get('/user/:id', (req, res) => {
  const user = db.getUser(req.params.id);
  res.json(user);  // Any user can access any user's data
});

// ✅ SECURE - Verify ownership
app.get('/user/:id', authenticate, (req, res) => {
  if (req.params.id !== req.user.id && !req.user.isAdmin) {
    return res.status(403).json({ error: 'Forbidden' });
  }
  const user = db.getUser(req.params.id);
  res.json(user);
});
```

### 6. Security Misconfiguration

**CORS Configuration:**
```javascript
// ❌ VULNERABLE
app.use(cors({ origin: '*' }));

// ✅ SECURE - Whitelist specific origins
app.use(cors({
  origin: ['https://myapp.com', 'https://www.myapp.com'],
  credentials: true,
}));
```

**HTTP Security Headers:**
```javascript
// ✅ SECURE - Use helmet.js
const helmet = require('helmet');
app.use(helmet());
app.use(helmet.contentSecurityPolicy({
  directives: {
    defaultSrc: ["'self'"],
    styleSrc: ["'self'", "'unsafe-inline'"],
    scriptSrc: ["'self'"],
    imgSrc: ["'self'", "data:", "https:"],
  },
}));
```

### 7. Cross-Site Scripting (XSS)

```javascript
// ❌ VULNERABLE
app.get('/search', (req, res) => {
  res.send(`<h1>Results for: ${req.query.q}</h1>`);
});

// ✅ SECURE - Escape output
const escapeHtml = (unsafe) => {
  return unsafe
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
};

app.get('/search', (req, res) => {
  res.send(`<h1>Results for: ${escapeHtml(req.query.q)}</h1>`);
});

// Better: Use templating engine with auto-escaping
app.get('/search', (req, res) => {
  res.render('search', { query: req.query.q });  // Auto-escaped
});
```

```python
# ✅ SECURE - Use Jinja2 auto-escaping
from flask import render_template_string

@app.route('/search')
def search():
    query = request.args.get('q', '')
    # Jinja2 auto-escapes by default
    return render_template_string('<h1>Results for: {{ query }}</h1>', query=query)
```

### 8. Insecure Deserialization

```python
# ❌ VULNERABLE
import pickle
data = pickle.loads(user_input)

# ✅ SECURE - Use JSON instead
import json
data = json.loads(user_input)

# If you must use pickle, validate and sanitize
# Or use safer alternatives like jsonpickle
```

### 9. Using Components with Known Vulnerabilities

**Regular Dependency Scanning:**
```bash
# Python
pip install pip-audit
pip-audit

# JavaScript
npm audit
npm audit fix

# Or use automated tools
npm install -g snyk
snyk test
snyk monitor
```

**Keep Dependencies Updated:**
```bash
# Python
pip list --outdated
pip install --upgrade package-name

# JavaScript
npm outdated
npm update

# Use automated tools
npx npm-check-updates -u
```

### 10. Insufficient Logging & Monitoring

```python
# ✅ SECURE - Comprehensive logging
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@app.route('/login', methods=['POST'])
def login():
    username = request.form['username']
    password = request.form['password']

    user = authenticate(username, password)
    if user:
        logger.info(f"Successful login: {username} from {request.remote_addr}")
        return "Success"
    else:
        logger.warning(f"Failed login attempt: {username} from {request.remote_addr}")
        return "Invalid credentials", 401
```

## Security Scanning Tools

### SAST (Static Application Security Testing)

**Bandit (Python):**
```bash
pip install bandit
bandit -r src/ -f json -o bandit-report.json

# Common issues detected:
# - Use of assert
# - Hardcoded passwords
# - SQL injection risks
# - Weak cryptography
```

**ESLint Security Plugin (JavaScript):**
```bash
npm install --save-dev eslint-plugin-security

# .eslintrc.js
module.exports = {
  plugins: ['security'],
  extends: ['plugin:security/recommended'],
};
```

**Semgrep (Multi-language):**
```bash
pip install semgrep
semgrep --config=auto ./src

# Detects:
# - SQL injection
# - XSS vulnerabilities
# - Command injection
# - Path traversal
```

**SonarQube:**
```bash
# Comprehensive security scanning
docker run -d -p 9000:9000 sonarqube
# Configure in CI/CD
```

### Dependency Scanning

**Snyk:**
```bash
npm install -g snyk
snyk auth
snyk test  # Test for vulnerabilities
snyk monitor  # Continuous monitoring
```

**Dependabot (GitHub):**
```yaml
# .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
    open-pull-requests-limit: 10
```

**Safety (Python):**
```bash
pip install safety
safety check
safety check --json
```

### Secret Scanning

**GitGuardian:**
```bash
pip install ggshield
ggshield secret scan path ./src
```

**detect-secrets:**
```bash
pip install detect-secrets
detect-secrets scan --baseline .secrets.baseline
```

**TruffleHog:**
```bash
docker run -it -v "$PWD:/pwd" trufflesecurity/trufflehog:latest \
  filesystem /pwd
```

## CI/CD Security Integration

### GitHub Actions

```yaml
name: Security Scan
on: [push, pull_request]

jobs:
  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Run Snyk
        uses: snyk/actions/node@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}

      - name: Run Bandit (Python)
        run: |
          pip install bandit
          bandit -r src/ -ll

      - name: Run Semgrep
        uses: returntocorp/semgrep-action@v1

      - name: Secret Scanning
        run: |
          pip install detect-secrets
          detect-secrets scan --baseline .secrets.baseline
```

## Secure Coding Checklist

### Input Validation
- [ ] All user input is validated
- [ ] Input length limits enforced
- [ ] Special characters sanitized
- [ ] File upload types restricted
- [ ] File size limits enforced

### Authentication & Authorization
- [ ] Strong password requirements (12+ chars, mixed case, numbers, symbols)
- [ ] Passwords hashed with bcrypt/argon2
- [ ] Multi-factor authentication available
- [ ] Session tokens are secure and expire
- [ ] Authorization checks on every endpoint
- [ ] Proper role-based access control

### Data Protection
- [ ] Sensitive data encrypted at rest
- [ ] HTTPS/TLS for data in transit
- [ ] No secrets in code or version control
- [ ] Environment variables for configuration
- [ ] PII data properly handled (GDPR compliance)

### API Security
- [ ] Rate limiting implemented
- [ ] API keys rotated regularly
- [ ] CORS properly configured
- [ ] Input validation on all endpoints
- [ ] Proper error messages (no sensitive info leaked)

### Database Security
- [ ] Parameterized queries used
- [ ] Least privilege database access
- [ ] Database credentials secured
- [ ] Regular backups
- [ ] SQL injection prevention

### Dependency Management
- [ ] Dependencies regularly updated
- [ ] Vulnerability scanning automated
- [ ] No known vulnerable packages
- [ ] Package integrity verified (lock files)

### Logging & Monitoring
- [ ] Security events logged
- [ ] Failed login attempts tracked
- [ ] No sensitive data in logs
- [ ] Log retention policy defined
- [ ] Alerting for suspicious activity

## Common Vulnerabilities by Language

### Python
- SQL injection via string formatting
- Command injection via `os.system()`
- Pickle deserialization
- YAML unsafe loading (`yaml.load()`)
- XML parsing without `defusedxml`

### JavaScript/Node.js
- SQL injection in raw queries
- Command injection via `child_process.exec()`
- eval() usage
- Insecure dependencies
- Prototype pollution

### Java
- SQL injection
- XML external entities (XXE)
- Insecure deserialization
- LDAP injection
- Path traversal

### Go
- SQL injection in raw queries
- Command injection
- Path traversal
- Improper error handling exposing stack traces
- Insecure randomness

## Emergency Response

If you discover a vulnerability:

1. **Assess Severity** (Use CVSS score)
   - Critical (9.0-10.0): Immediate action
   - High (7.0-8.9): Fix within 24 hours
   - Medium (4.0-6.9): Fix within 1 week
   - Low (0.1-3.9): Fix in next release

2. **Isolate the Issue**
   - Don't commit vulnerable code
   - Revert if already in production
   - Block affected endpoints if necessary

3. **Fix and Test**
   - Apply security patch
   - Add tests to prevent regression
   - Verify fix doesn't break functionality

4. **Deploy and Monitor**
   - Fast-track security fixes
   - Monitor for exploitation attempts
   - Review logs for past attacks

5. **Post-Mortem**
   - Document what happened
   - Update security procedures
   - Add preventive measures

## Resources

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [CWE Top 25](https://cwe.mitre.org/top25/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [Security Headers](https://securityheaders.com/)
- [Snyk Vulnerability Database](https://security.snyk.io/)

---

**Enforcement Level**: SUGGEST (Advisory)
**Priority**: CRITICAL
**Scope**: All code handling sensitive data, user input, or external systems
**Tools**: Snyk, Bandit, Semgrep, SonarQube, detect-secrets
