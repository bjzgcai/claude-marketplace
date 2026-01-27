# Quick Start Guide - Ralph Wiggum Plugin

Get started with the Ralph Wiggum technique in 5 minutes!

## What You Need

- Claude Code CLI installed
- This plugin installed in your plugins directory
- A project directory to work in

## Platform Support

✅ **Works on:**
- Linux (bash)
- macOS (bash)
- WSL (Windows Subsystem for Linux - bash)
- Windows PowerShell
- PowerShell Core (any platform)

**No configuration needed!** The plugin auto-detects your platform.

## Your First Ralph Loop (2 Minutes)

### Step 1: Navigate to Your Project

```bash
cd /path/to/your/project
```

### Step 2: Start a Simple Ralph Loop

```bash
/ralph-loop "Create a Python file with a function that adds two numbers and a test for it. Output <promise>DONE</promise> when tests pass." --completion-promise "DONE" --max-iterations 10
```

### Step 3: Watch It Work!

Ralph will:
1. Create the Python file
2. Write the add function
3. Create tests
4. Run the tests
5. Fix any issues
6. Output `<promise>DONE</promise>` when complete

The loop automatically exits when the promise is detected!

## Try a More Realistic Example (5 Minutes)

Create a simple TODO CLI application:

```bash
/ralph-loop "Create a Python CLI todo application:

Requirements:
- Add new todos
- List all todos
- Mark todos complete
- Save to JSON file

Include pytest tests for all functions.
Output <promise>TESTS_PASS</promise> when all tests pass." --completion-promise "TESTS_PASS" --max-iterations 25
```

Ralph will iteratively build the application, write tests, and refine until all tests pass!

## Understanding the Command

```bash
/ralph-loop "YOUR TASK" [OPTIONS]
```

**Required:**
- `"YOUR TASK"` - Clear description of what to build

**Options:**
- `--max-iterations N` - Safety limit (recommended: 20-50)
- `--completion-promise "TEXT"` - Exit phrase when done

## Key Concepts

### 1. Completion Promises

A completion promise is your exit condition:

```
Output <promise>COMPLETE</promise> when done.
```

**Rules:**
- Only output when truly complete
- Must match `--completion-promise` exactly
- Don't use false promises to escape

### 2. Iteration Limits

Always set a maximum:

```bash
--max-iterations 30  # Prevents infinite loops
```

**Recommended limits:**
- Simple tasks: 15-25
- Medium tasks: 25-40
- Complex tasks: 40-60

### 3. Self-Reference

Between iterations, Ralph:
- Sees file changes from previous iterations
- Reads git commit history
- Learns from past mistakes
- Builds incrementally

## Common Commands

### Start a Loop
```bash
/ralph-loop "YOUR TASK" --max-iterations 30
```

### Check Loop Status
```bash
cat .claude/ralph-loop.local.md
```

### Cancel a Loop
```bash
/cancel-ralph
```

### Get Help
```bash
/ralph-help
```

## Example: Test-Driven Development

Perfect for TDD workflows:

```bash
/ralph-loop "Create a calculator module:
1. Write comprehensive pytest tests first
2. Implement add, subtract, multiply, divide
3. Handle edge cases (division by zero, etc.)
4. All tests must pass

Output <promise>CALCULATOR_READY</promise> when tests pass." --completion-promise "CALCULATOR_READY" --max-iterations 20
```

Ralph will:
1. Write tests first
2. Implement features
3. Run tests
4. Fix failures
5. Iterate until all pass

## Tips for Success

### ✅ Good Prompts

**Specific and measurable:**
```bash
/ralph-loop "Build REST API with GET, POST, PUT, DELETE endpoints. Include tests. Output <promise>API_READY</promise> when tests pass." --completion-promise "API_READY" --max-iterations 35
```

**Phased approach:**
```bash
/ralph-loop "Phase 1: Setup project. Phase 2: Add features. Phase 3: Add tests. Output <promise>DONE</promise> when complete." --completion-promise "DONE" --max-iterations 40
```

### ❌ Avoid These

**Too vague:**
```bash
/ralph-loop "Make something cool" --max-iterations 20
```

**No exit criteria:**
```bash
/ralph-loop "Build a website"
# Missing --completion-promise and may run until max iterations
```

**Subjective goals:**
```bash
/ralph-loop "Improve the code" --max-iterations 20
# What counts as "improved"?
```

## Troubleshooting

### Loop Not Starting?

Check that you're in a project directory:
```bash
pwd  # Should be in your project, not home directory
```

### Loop Running Too Long?

Cancel and restart with clearer requirements:
```bash
/cancel-ralph
/ralph-loop "CLEARER TASK with specific deliverables" --max-iterations 25
```

### Tests Keep Failing?

Ralph will keep iterating to fix them! This is expected behavior. If stuck after many iterations, cancel and review the requirements.

## Next Steps

1. **Try the examples** in `RALPH_EXAMPLES.md`
2. **Read the full guide** with `/ralph-help`
3. **Experiment** with different prompts
4. **Start small** and work up to complex tasks

## Real-World Use Case

Here's a real example of building a complete feature:

```bash
/ralph-loop "Create a user authentication system:

Backend (Node.js + Express):
- POST /register - Create account
- POST /login - Authenticate user
- POST /logout - End session
- GET /profile - Get user info

Requirements:
- Hash passwords with bcrypt
- Use JWT tokens
- Input validation
- Error handling
- Unit and integration tests

Database:
- SQLite for simplicity
- User table with id, email, password_hash, created_at

Output <promise>AUTH_COMPLETE</promise> when:
- All endpoints working
- All tests passing
- Security best practices followed" --completion-promise "AUTH_COMPLETE" --max-iterations 50
```

This would take hours manually but Ralph can iterate autonomously!

## Remember

- **Iteration > Perfection**: Let Ralph iterate multiple times
- **Trust the Process**: Don't cancel prematurely
- **Clear Goals**: Specific requirements lead to better results
- **Use Tests**: Automatic verification is key
- **Safety Limits**: Always set `--max-iterations`

## Getting Help

- Run `/ralph-help` for comprehensive documentation
- Check `RALPH_EXAMPLES.md` for more examples
- Read `README.md` for full feature list

---

**Ready to start?** Try the 2-minute example above and experience Ralph's power! 🚀

Happy coding! 🔄
