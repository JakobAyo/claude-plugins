---
name: git-context-commits
description: Enforce descriptive git commit messages that preserve AI-assisted coding context. Use when committing, creating commits, git commit, staging changes, or discussing commit messages. Ensures each commit captures the full context of what was done, why, and how during vibe coding sessions.
---

# Git Context Commits

## Purpose

Enforce descriptive, context-rich git commit messages during AI-assisted "vibe coding" sessions. Each commit should serve as a comprehensive checkpoint that captures:

- **What** was accomplished
- **Why** it was needed
- **How** it was implemented
- **Decisions** made along the way

## When to Use

This skill activates when:
- Creating git commits
- Discussing commit messages
- Staging changes for commit
- Reviewing what to commit
- Any git workflow involving message creation

## Commit Message Format

### Structure

```
<type>(<scope>): <short summary>

<detailed description>

Context:
- <key context point 1>
- <key context point 2>

Changes:
- <specific change 1>
- <specific change 2>

Decisions:
- <decision made and reasoning>

AI-Assisted: Yes
Session-Step: <step number if tracking>
```

### Types

| Type       | Description                                      |
|------------|--------------------------------------------------|
| `feat`     | New feature or capability                        |
| `fix`      | Bug fix or error correction                      |
| `refactor` | Code restructuring without behavior change       |
| `docs`     | Documentation updates                            |
| `style`    | Formatting, whitespace, no code change           |
| `test`     | Adding or updating tests                         |
| `chore`    | Build process, dependencies, tooling             |
| `wip`      | Work in progress checkpoint                      |
| `explore`  | Exploratory changes during vibe coding           |

### Scope Examples

- `auth`, `api`, `ui`, `db`, `config`, `tests`, `core`
- Use the primary area affected by the changes

## Context Preservation Guidelines

### 1. Capture the "Why"

Bad:
```
fix: update user validation
```

Good:
```
fix(auth): prevent empty email submissions

Context:
- Users could submit forms with whitespace-only emails
- This bypassed frontend validation but failed silently on backend
- Discovered during testing the registration flow

Changes:
- Added trim() before email validation
- Added explicit empty string check
- Updated error message for clarity
```

### 2. Document Decisions Made

When making choices during implementation, record them:

```
refactor(api): switch from callbacks to async/await

Context:
- Codebase had mixed async patterns causing confusion
- Error handling was inconsistent across endpoints

Decisions:
- Chose async/await over Promises for readability
- Kept backward compatibility by maintaining same function signatures
- Did NOT refactor database layer (separate concern)
```

### 3. Track AI Collaboration Steps

For vibe coding sessions, mark the progression:

```
feat(dashboard): add user metrics widget

Context:
- Part of analytics feature buildout
- Third step in dashboard enhancement session
- Building on previous chart component work

Session-Step: 3
Previous-Steps:
- Step 1: Set up chart library (commit abc123)
- Step 2: Create base widget component (commit def456)

AI-Assisted: Yes
Approach: Iterative refinement with Claude
```

### 4. Include Problem-Solution Pairs

```
fix(perf): resolve N+1 query in user list

Problem:
- User list page took 5+ seconds to load
- Each user triggered separate role query
- 100 users = 101 database queries

Solution:
- Added eager loading for user roles
- Single query now fetches all data
- Load time reduced to <200ms

Investigation:
- Used query logging to identify issue
- Confirmed fix with EXPLAIN ANALYZE
```

## Minimum Requirements

Every commit message MUST include:

1. **Type and scope** - What category and area
2. **Clear summary** - What was done (imperative mood)
3. **Context section** - Why this change was needed
4. **Changes list** - Specific modifications made

For AI-assisted sessions, also include:
5. **AI-Assisted marker** - Acknowledge collaboration
6. **Session context** - Where this fits in the workflow

## Anti-Patterns to Avoid

### Vague Messages
- "fix stuff"
- "updates"
- "wip"
- "changes"

### Missing Context
- "add validation" (which validation? why?)
- "refactor code" (what code? what improvement?)

### No Decision Trail
- Making architectural choices without documenting reasoning
- Switching approaches without explaining why

### Lost Session Context
- Commits that don't connect to previous work
- No indication of progression or dependencies

## Examples

### Feature Addition
```
feat(notifications): add real-time push notifications

Context:
- Users requested immediate updates for critical events
- Previous polling approach caused 30-second delays
- Part of user engagement improvement initiative

Changes:
- Integrated WebSocket connection for live updates
- Added notification permission request flow
- Created notification center UI component
- Implemented fallback to polling for unsupported browsers

Decisions:
- Used native WebSocket over Socket.io (lighter weight)
- Notifications auto-dismiss after 5 seconds (user feedback)
- Stored last 50 notifications locally (offline access)

AI-Assisted: Yes
Session-Step: 2 of 4
```

### Bug Fix
```
fix(checkout): resolve cart total calculation error

Problem:
- Cart showed incorrect total when discount applied
- Discount was subtracted before tax calculation
- Resulted in customers being overcharged

Root Cause:
- Order of operations in calculateTotal() was wrong
- Tax was being applied to full price, not discounted price

Solution:
- Reordered calculation: subtotal -> discount -> tax
- Added unit tests for discount + tax scenarios
- Verified against 10 edge cases

Context:
- Bug reported by 3 customers this week
- Affects all orders with percentage discounts
- Fix is backward compatible

AI-Assisted: Yes
```

### Exploratory/WIP
```
explore(search): prototype fuzzy search implementation

Context:
- Evaluating search improvements for better UX
- Testing Fuse.js vs custom implementation
- Not production ready - checkpoint for comparison

Current State:
- Basic fuzzy matching working
- Performance acceptable for <1000 items
- UI integration pending

Next Steps:
- Benchmark with production data volume
- Compare with Elasticsearch option
- Get team feedback on relevance scoring

AI-Assisted: Yes
Session-Step: 1 (exploration phase)
```

## Integration with Workflow

### Before Committing

1. Review all staged changes
2. Identify the primary purpose
3. Note any decisions made during implementation
4. Consider how this fits into larger context

### Writing the Message

1. Start with type and clear summary
2. Add context explaining the "why"
3. List specific changes made
4. Document any decisions and reasoning
5. Mark AI assistance and session context

### After Committing

The commit message should allow anyone (including future you) to:
- Understand what changed without reading code
- Know why the change was made
- Recreate the decision-making process
- Continue the work in a future session

## Quick Reference

```
<type>(<scope>): <imperative summary under 72 chars>

Context:
- Why was this change needed?
- What problem does it solve?

Changes:
- Specific modification 1
- Specific modification 2

Decisions:
- Choice made: <reasoning>

AI-Assisted: Yes/No
Session-Step: <n> (if applicable)
```

---

**Skill Status**: Active
**Line Count**: < 500
