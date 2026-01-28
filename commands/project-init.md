# Project Init

Initialize a new project with git, essential skills, and comprehensive planning documents.

## Workflow

Follow these steps to initialize a new project:

1. **Initialize Git Repository**
   - Run `git init` to create a new git repository
   - Confirm repository initialization

2. **Create .gitignore File**
   - Create an empty `.gitignore` file at the project root
   - This will be populated based on project type

3. **Install Essential Skills**
   - Copy `git-workflow.zip` from `~/Claude/claude-factory/skills/` to `.claude/skills/`
   - Copy `docs-organizer.zip` from `~/Claude/claude-factory/skills/` to `.claude/skills/`
   - Unzip both files in `.claude/skills/`
   - Remove the .zip files after extraction

4. **Create CLAUDE.md File**

   Create a `CLAUDE.md` file at the project root with the following content:

   ```markdown
   # [Project Name]

   ## Project Instructions

   This file contains important instructions for Claude Code when working on this project.

   ## Git Workflow

   **IMPORTANT**: Always use the `git-workflow` skill for ALL git operations in this project, including:
   - Creating branches (feature, bugfix, hotfix, refactor)
   - Making commits (must follow Conventional Commits format)
   - Merging branches (use merge commit strategy with --no-ff)
   - Managing pull requests
   - Validating commit messages

   Use the Skill tool to invoke: `git-workflow` before performing any git operations.

   ## Documentation Organization

   **IMPORTANT**: Always use the `docs-organizer` skill after creating or modifying markdown files to ensure:
   - Documentation is properly structured and organized
   - Cross-references and links are maintained
   - Documentation follows project standards
   - Table of contents and navigation are updated

   Use the Skill tool to invoke: `docs-organizer` after creating or editing any markdown file.

   ## Project-Specific Instructions

   [Add any project-specific instructions, coding standards, or workflows here]
   ```

   Replace `[Project Name]` with the actual project name gathered in the next step.

5. **Gather Project Requirements**

   Ask the user the following questions to understand the project:

   - What is the name of this project?
   - What is the primary purpose or goal of this project?
   - What programming language(s) will be used? (e.g., Python, JavaScript, Go, etc.)
   - What type of project is this? (e.g., web application, CLI tool, library, API service, mobile app, etc.)
   - What framework(s) or major dependencies will be used? (if any)
   - Who is the target audience or end user?
   - What are the key features or functionality requirements?
   - Are there any specific technical constraints or requirements? (e.g., performance, scalability, security)
   - What is the expected timeline or milestones?
   - Are there any integration requirements with external services or APIs?

6. **Create DevelopmentPlan.md**

   Based on the gathered requirements, create a comprehensive `DevelopmentPlan.md` file with the following structure:

   ```markdown
   # Development Plan: [Project Name]

   ## Project Overview
   - **Project Name**: [name]
   - **Purpose**: [description]
   - **Type**: [project type]
   - **Language(s)**: [languages]
   - **Framework(s)**: [frameworks]

   ## Target Audience
   [Description of target users]

   ## Key Features
   1. [Feature 1]
   2. [Feature 2]
   3. [Feature 3]
   ...

   ## Technical Requirements
   ### Languages & Frameworks
   - [List technologies]

   ### Dependencies
   - [List major dependencies]

   ### Constraints
   - [Performance requirements]
   - [Scalability considerations]
   - [Security requirements]
   - [Other constraints]

   ## Development Phases
   ### Phase 1: Setup & Foundation
   - [ ] Initialize project structure
   - [ ] Set up development environment
   - [ ] Configure build tools
   - [ ] Set up testing framework

   ### Phase 2: Core Features
   - [ ] [Core feature 1]
   - [ ] [Core feature 2]
   - [ ] [Core feature 3]

   ### Phase 3: Additional Features
   - [ ] [Additional feature 1]
   - [ ] [Additional feature 2]

   ### Phase 4: Polish & Deployment
   - [ ] Performance optimization
   - [ ] Security audit
   - [ ] Documentation
   - [ ] Deployment setup

   ## Timeline
   - **Phase 1**: [timeframe]
   - **Phase 2**: [timeframe]
   - **Phase 3**: [timeframe]
   - **Phase 4**: [timeframe]

   ## Integration Requirements
   - [External service 1]
   - [External service 2]
   - [API integrations]

   ## Success Criteria
   - [Criterion 1]
   - [Criterion 2]
   - [Criterion 3]
   ```

7. **Create DevelopmentValidation.md**

   Create a `DevelopmentValidation.md` file to track validation and testing:

   ```markdown
   # Development Validation: [Project Name]

   ## Validation Strategy

   This document tracks validation activities to ensure the project meets requirements and quality standards.

   ## Code Quality Checks
   - [ ] Code follows style guide and linting rules
   - [ ] No critical security vulnerabilities
   - [ ] Code review completed
   - [ ] Documentation is complete and accurate

   ## Testing Checklist
   ### Unit Tests
   - [ ] All core functions have unit tests
   - [ ] Test coverage meets minimum threshold (specify: ___%)
   - [ ] Edge cases are tested
   - [ ] Error handling is tested

   ### Integration Tests
   - [ ] API endpoints tested
   - [ ] Database operations tested
   - [ ] External service integrations tested
   - [ ] Authentication/authorization tested

   ### System Tests
   - [ ] End-to-end user workflows tested
   - [ ] Performance benchmarks met
   - [ ] Security testing completed
   - [ ] Cross-browser/platform testing (if applicable)

   ## Feature Validation
   ### [Feature 1]
   - [ ] Requirements met
   - [ ] User acceptance criteria satisfied
   - [ ] Performance acceptable
   - [ ] No critical bugs

   ### [Feature 2]
   - [ ] Requirements met
   - [ ] User acceptance criteria satisfied
   - [ ] Performance acceptable
   - [ ] No critical bugs

   ## Deployment Validation
   - [ ] Build process successful
   - [ ] Environment variables configured
   - [ ] Database migrations tested
   - [ ] Deployment scripts validated
   - [ ] Rollback procedure tested
   - [ ] Monitoring and logging configured

   ## Documentation Validation
   - [ ] README is complete
   - [ ] API documentation generated
   - [ ] User guide created
   - [ ] Installation instructions tested
   - [ ] Contributing guidelines provided

   ## Security Validation
   - [ ] Dependencies scanned for vulnerabilities
   - [ ] Authentication mechanisms secure
   - [ ] Data encryption implemented where needed
   - [ ] Input validation in place
   - [ ] OWASP Top 10 vulnerabilities addressed

   ## Performance Validation
   - [ ] Load testing completed
   - [ ] Response times within acceptable range
   - [ ] Resource usage optimized
   - [ ] Bottlenecks identified and resolved

   ## Sign-off
   - [ ] Development team approval
   - [ ] QA team approval
   - [ ] Stakeholder approval
   - [ ] Ready for production deployment

   ## Issues & Blockers
   | Issue | Severity | Status | Owner | Notes |
   |-------|----------|--------|-------|-------|
   |       |          |        |       |       |

   ## Validation Notes
   [Add any additional notes about validation activities, findings, or decisions]
   ```

8. **Final Steps**
   - Confirm all files have been created successfully
   - Provide a summary of what was set up
   - Suggest next steps for the user

## Important Notes
- Ensure the `.claude/skills/` directory exists before copying skills
- Handle errors gracefully if skill files are not found
- Validate that git init was successful before proceeding
- The questions should be asked interactively to gather complete information
- The planning documents should be detailed and actionable

