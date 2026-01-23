# Critical Bug Review - Output Template

## Report Structure

```markdown
# Critical Bug Review Report

**Scope**: {what was reviewed}
**Date**: {YYYY-MM-DD}
**Reviewed By**: Claude Code

## Summary

- **Total Critical Bugs Found**: {count}
```

## Bug Entry Template

For each critical bug found, use this exact format. **Important**: Each section must be thoroughly descriptive with multiple sentences. Never write single-sentence descriptions. Provide enough context that a developer unfamiliar with the codebase can fully understand the issue.

```markdown
## Bug {number}: {Bug Title}

### Expected Behavior

{Describe in detail what the code should do when functioning correctly. Explain the intended behavior, what inputs it should handle, what outputs it should produce, and how it should integrate with other parts of the system. Use 3-5 sentences minimum.}

### Current Behavior

{Describe in detail what the code actually does - the incorrect/buggy behavior. Explain the symptoms, error messages, and user-visible impact. Describe how this differs from expected behavior and what consequences it has. Use 3-5 sentences minimum.}

### Possible Solution

{Provide a detailed high-level approach to fix the bug. Explain the strategy, why this approach is recommended, and any considerations or trade-offs. Mention any alternative approaches if relevant. Use 3-5 sentences minimum.}

### Steps to Reproduce

1. {Detailed first step with specific actions, values, or conditions}
2. {Detailed second step explaining what happens}
3. {Detailed third step showing progression to the bug}
4. {Detailed fourth step describing the observable failure}
5. {Additional steps as needed to fully reproduce}

### Context (Environment)

{Provide comprehensive environment details including:

- File path and specific line numbers
- Function/component name and its role
- Dependencies and related modules
- Calling code and upstream/downstream components
- Runtime conditions when the bug manifests
- Any relevant configuration or state}

### Detailed Description

{Provide an in-depth multi-paragraph explanation covering:

- Root cause analysis of why the bug exists
- The original assumptions that led to the bug
- Technical details of the failure mechanism
- Impact assessment including affected features and users
- Related code paths or similar patterns that may have the same issue
  Use at least 2-3 paragraphs.}

### Possible Implementation

{Provide concrete code changes with full context:

- Show the fix with surrounding code for context
- Explain each part of the implementation
- Include any necessary error handling
- Suggest related tests or validation steps
- Note any follow-up work that may be needed}

---
```

## Example Bug Entry

> **Note**: Each section should be thoroughly descriptive with multiple sentences. Avoid single-sentence descriptions. Provide enough detail that a developer unfamiliar with the code can fully understand the bug, its impact, and how to fix it.

````markdown
## Bug 1: Unhandled null reference in user data processing causes application crash

### Expected Behavior

The `processUserData` function is responsible for retrieving and transforming user information from the database into a format suitable for the frontend application. When a user ID is provided that does not correspond to an existing user in the database, the function should gracefully handle this scenario by returning a default user data object. This default object should contain safe placeholder values that allow the calling code to continue operating without errors. The function should never throw an exception or cause a crash when encountering missing data, as this is a foreseeable edge case in normal application operation.

### Current Behavior

When the `processUserData` function receives a user ID that doesn't exist in the database, the application crashes with an unhandled exception: "Cannot read property 'preferences' of null". This occurs because the database query returns `null` for non-existent users, and the function immediately attempts to access properties on this null object without any validation. The crash propagates up the call stack and terminates the current request, resulting in a 500 Internal Server Error being returned to the client. This behavior is inconsistent with other similar functions in the codebase that handle missing data gracefully, and it breaks the user experience whenever a deleted or non-existent user ID is referenced.

### Possible Solution

Implement a defensive null check immediately after the database query returns, before attempting to access any properties on the user object. If the user is null or undefined, the function should return a predefined default user data object that contains safe placeholder values. Additionally, consider logging a warning when this fallback is triggered to help identify patterns of invalid user ID references in the application. The fix should be minimal and focused, avoiding any broader refactoring of the function's structure while ensuring all code paths that access user properties are protected.

### Steps to Reproduce

1. Identify a user ID that does not exist in the database (e.g., a deleted user ID or a randomly generated UUID that was never assigned)
2. Navigate to any part of the application that triggers the `processUserData` function with this invalid user ID, such as viewing a user profile page or loading user-related dashboard data
3. Observe that the database query executes successfully but returns null for the user object
4. The function proceeds to line 89 where it attempts to access `user.preferences`, causing a TypeError to be thrown
5. The error propagates up and the application returns a 500 error to the client, with the full stack trace logged in the server console

### Context (Environment)

- **File**: `apps/metris.web/src/services/user.service.ts`
- **Line(s)**: 87-90 (the vulnerable code block spans these lines, with the crash occurring specifically at line 89)
- **Function**: `processUserData` (exported async function, called from multiple controllers)
- **Dependencies**: This function depends on `UserRepository` for database access and `DatabaseConnection` for the underlying connection pool. It is called by `UserController`, `DashboardController`, and `ProfileController`.
- **Related Components**: The `UserMapper` utility is used downstream to transform the data, and will also fail if passed null data.
- **Runtime Conditions**: This bug manifests in production when users are deleted but references to their IDs persist in other tables, or when URL parameters are manually manipulated.

### Detailed Description

The `processUserData` function is a critical part of the user data pipeline that retrieves raw user records from the database and transforms them into a structured format for consumption by frontend components. The function was originally written under the assumption that all user IDs passed to it would be valid and correspond to existing database records. However, this assumption breaks down in several real-world scenarios: when users are soft-deleted but their IDs are still referenced in activity logs, when URL parameters are manually edited by users or attackers, or when race conditions occur between user deletion and data fetching operations.

The root cause of the bug is the missing null check between the database query (line 87: `const user = await this.userRepository.findById(userId)`) and the property access (line 89: `const preferences = user.preferences`). The `findById` method correctly returns `null` when no matching record is found, which is standard behavior for this type of query. However, the function author did not account for this possibility and proceeded directly to accessing nested properties.

The impact of this bug extends beyond a simple crash. When this error occurs in production, it generates noise in error monitoring systems, degrades user trust when they encounter 500 errors, and can potentially mask other issues if error rates become normalized. Furthermore, since this function is called from multiple controllers, the bug has a wide blast radius affecting user profiles, dashboards, and any feature that displays user information.

### Possible Implementation

The fix requires adding a guard clause after the database query to handle the null case. Here is the recommended implementation that maintains consistency with error handling patterns used elsewhere in the codebase:

```typescript
const user = await this.userRepository.findById(userId);

// Guard clause: return default data if user not found
if (!user) {
  console.warn(`[processUserData] User not found for ID: ${userId}. Returning default data.`);
  return {
    id: userId,
    preferences: defaultPreferences,
    profile: defaultProfile,
    isDefault: true, // Flag to indicate this is fallback data
  };
}

// Now safe to access user properties
const preferences = user.preferences;
const profile = user.profile;

// Continue with normal processing...
```

Additionally, consider adding a unit test that specifically verifies the function handles null users gracefully:

```typescript
it('should return default data when user does not exist', async () => {
  userRepository.findById.mockResolvedValue(null);
  const result = await processUserData('non-existent-id');
  expect(result.isDefault).toBe(true);
  expect(result.preferences).toEqual(defaultPreferences);
});
```
````

---

```

## File Naming Convention

Reports should be saved to `docs/code-review/` with the naming pattern:
```

critical-bugs-{scope}-{YYYY-MM-DD}.md

```

Examples:
- `critical-bugs-metris-web-2026-01-14.md`
- `critical-bugs-full-codebase-2026-01-14.md`
- `critical-bugs-auth-service-2026-01-14.md`
```
