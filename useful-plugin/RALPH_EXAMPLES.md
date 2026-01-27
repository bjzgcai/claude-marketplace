# Ralph Wiggum Examples

This file contains practical examples of using the Ralph Wiggum technique with various types of tasks.

## Example 1: Simple Todo CLI (Beginner)

**Task**: Create a basic command-line todo list application

```bash
/ralph-loop "Create a Python CLI todo app with these features:
- Add new todos
- List all todos
- Mark todos as complete
- Delete todos
- Save/load from JSON file

Include pytest tests for all functions.
Output <promise>TESTS_PASS</promise> when all tests pass." --completion-promise "TESTS_PASS" --max-iterations 25
```

**Why this works:**
- Clear, enumerated requirements
- Specific completion criteria (tests passing)
- Reasonable iteration limit
- Automatic verification via tests

---

## Example 2: REST API with TDD (Intermediate)

**Task**: Build a RESTful API using test-driven development

```bash
/ralph-loop "Build a Task Management REST API using Node.js and Express:

Phase 1: Setup
- Initialize Node.js project with TypeScript
- Set up Express server
- Configure testing with Jest

Phase 2: Implement Endpoints
- POST /tasks - Create task
- GET /tasks - List all tasks
- GET /tasks/:id - Get single task
- PUT /tasks/:id - Update task
- DELETE /tasks/:id - Delete task

Phase 3: Add Features
- Input validation with Joi
- Error handling middleware
- Request logging

Phase 4: Testing
- Write unit tests for each endpoint
- Write integration tests
- Ensure 100% test coverage

Output <promise>API_COMPLETE</promise> when all tests pass and coverage is 100%." --completion-promise "API_COMPLETE" --max-iterations 50
```

**Why this works:**
- Phased approach breaks down complexity
- TDD ensures quality
- Measurable completion criteria
- Higher iteration limit for complexity

---

## Example 3: Code Refactoring (Advanced)

**Task**: Refactor legacy code with comprehensive testing

```bash
/ralph-loop "Refactor the legacy code in src/legacy/ directory:

Goals:
1. Add TypeScript types to all functions
2. Extract duplicate code into reusable utilities
3. Write comprehensive tests BEFORE refactoring
4. Refactor while keeping tests green
5. Improve code organization and structure
6. Add JSDoc comments

Success criteria:
- All existing functionality preserved
- Test coverage > 90%
- No TypeScript errors
- All tests passing
- Code complexity reduced

Output <promise>REFACTOR_COMPLETE</promise> when done." --completion-promise "REFACTOR_COMPLETE" --max-iterations 40
```

**Why this works:**
- Tests-first approach prevents regressions
- Clear success metrics
- Iterative improvement aligns with Ralph's strengths

---

## Example 4: Data Processing Pipeline (Specialized)

**Task**: Build an ETL pipeline with validation

```bash
/ralph-loop "Create a data processing pipeline in Python:

Requirements:
1. Extract data from CSV files in data/input/
2. Transform: clean, validate, normalize data
3. Load results into SQLite database
4. Generate summary report

Pipeline should:
- Handle malformed data gracefully
- Log all operations
- Provide progress feedback
- Be idempotent (safe to re-run)

Testing:
- Unit tests for each transformation
- Integration test with sample data
- Verify database schema and data

Output <promise>PIPELINE_READY</promise> when tests pass and documentation is complete." --completion-promise "PIPELINE_READY" --max-iterations 35
```

---

## Example 5: Frontend Component Library (Creative)

**Task**: Create a React component library

```bash
/ralph-loop "Build a React component library with TypeScript:

Components to create:
- Button (variants: primary, secondary, danger)
- Input (with validation states)
- Card (with header, body, footer)
- Modal (with animations)
- Alert (info, warning, error, success)

Requirements:
- TypeScript interfaces for all props
- Storybook stories for each component
- CSS modules for styling
- Unit tests with React Testing Library
- Accessibility compliance (WCAG 2.1 AA)

Output <promise>LIBRARY_READY</promise> when all components have stories, tests, and pass a11y checks." --completion-promise "LIBRARY_READY" --max-iterations 45
```

---

## Example 6: Bug Fix with Regression Tests (Practical)

**Task**: Fix a bug and prevent regression

```bash
/ralph-loop "Fix the authentication bug reported in issue #123:

Steps:
1. Reproduce the bug with a failing test
2. Investigate root cause
3. Implement fix
4. Verify test passes
5. Add additional tests to prevent regression
6. Update documentation if needed

Output <promise>BUG_FIXED</promise> when:
- Bug is fixed
- All tests pass (including new regression tests)
- Code review checklist completed" --completion-promise "BUG_FIXED" --max-iterations 20
```

---

## Example 7: Documentation Generation (Meta)

**Task**: Generate comprehensive documentation

```bash
/ralph-loop "Generate complete documentation for the project:

Documentation needed:
1. README.md with setup instructions
2. API.md documenting all endpoints
3. ARCHITECTURE.md explaining system design
4. CONTRIBUTING.md for contributors
5. Examples in examples/ directory

Requirements:
- Clear, concise writing
- Code examples that run successfully
- Diagrams where helpful (mermaid format)
- Table of contents
- Links between documents

Output <promise>DOCS_COMPLETE</promise> when all docs written and examples verified." --completion-promise "DOCS_COMPLETE" --max-iterations 30
```

---

## Example 8: Without Completion Promise (Time-boxed)

**Task**: Exploratory task with time limit only

```bash
/ralph-loop "Improve the performance of the image processing module:

Goals:
- Profile current performance
- Identify bottlenecks
- Implement optimizations
- Benchmark improvements
- Document changes

Run for maximum 25 iterations and report findings." --max-iterations 25
```

**Note**: Without a completion promise, Ralph will run until max iterations. Good for exploratory work.

---

## Tips for Writing Effective Ralph Prompts

### 1. Be Specific About Deliverables
❌ "Build a website"
✅ "Build a landing page with hero section, features grid, testimonials, and contact form"

### 2. Include Verification Steps
❌ "Add validation"
✅ "Add validation with Joi schema and write tests to verify error messages"

### 3. Use Completion Promises Wisely
❌ Generic: `<promise>DONE</promise>`
✅ Specific: `<promise>ALL_TESTS_PASSING</promise>`

### 4. Break Down Complex Tasks
❌ "Build a complete SaaS application"
✅ "Build authentication system: user registration, login, password reset, with tests"

### 5. Set Realistic Iteration Limits
- Simple tasks: 15-25 iterations
- Medium tasks: 25-40 iterations
- Complex tasks: 40-60 iterations
- Exploratory: 20-30 iterations

### 6. Leverage Test-Driven Development
Always include testing in your prompts:
```
1. Write tests first
2. Implement features to pass tests
3. Output completion promise when tests pass
```

---

## Common Pitfalls to Avoid

### ❌ Don't: Use Subjective Completion Criteria
```bash
/ralph-loop "Make the code better" --max-iterations 20
```

### ✅ Do: Use Objective Metrics
```bash
/ralph-loop "Reduce code complexity: aim for cyclomatic complexity < 10, extract functions > 50 lines, add unit tests" --max-iterations 30
```

---

### ❌ Don't: Output False Promises
Never output `<promise>COMPLETE</promise>` unless truly done, even if stuck.

### ✅ Do: Trust the Process
Let Ralph iterate. If stuck, it will try different approaches.

---

### ❌ Don't: Skip Iteration Limits
```bash
/ralph-loop "Build everything"  # No limit = risky
```

### ✅ Do: Always Set Max Iterations
```bash
/ralph-loop "Build everything" --max-iterations 50  # Safety net
```

---

## Monitoring Ralph Progress

While Ralph runs, you can:

1. Check current iteration: `cat .claude/ralph-loop.local.md`
2. View recent commits: `git log --oneline -10`
3. Check test status: `npm test` or `pytest`
4. Cancel if needed: `/cancel-ralph`

---

## Advanced: Chaining Ralph Loops

For very complex projects, chain multiple Ralph loops:

```bash
# Phase 1: Foundation
/ralph-loop "Set up project structure and core utilities" --max-iterations 20

# (After Phase 1 completes)

# Phase 2: Features
/ralph-loop "Implement main features with tests" --max-iterations 40

# (After Phase 2 completes)

# Phase 3: Polish
/ralph-loop "Add error handling, logging, documentation" --max-iterations 25
```

---

## Cross-Platform Notes

Ralph works identically on all platforms:
- **Linux/macOS/WSL**: Uses bash scripts automatically
- **Windows PowerShell**: Uses PowerShell scripts automatically
- **PowerShell Core**: Works on any OS

No configuration needed - the plugin detects your platform automatically!

---

**Happy Ralph-ing! 🔄**

Remember: The best way to learn Ralph is to try it. Start with simple tasks and work your way up to complex projects.
