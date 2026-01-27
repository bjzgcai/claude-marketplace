---
description: "Explain Ralph Wiggum technique and available commands"
hide-from-slash-command-tool: "true"
---

# Ralph Wiggum Plugin - Cross-Platform Edition

## What is Ralph?

**Ralph is a Bash loop.** More specifically, it's a continuous self-referential AI agent loop that enables iterative, autonomous development within Claude Code.

The technique is simple: instead of running Claude once and getting one response, Ralph runs Claude in a `while true` loop, feeding it the **same prompt** repeatedly until completion. Between iterations, your work persists in files and git history, allowing you to build incrementally on previous attempts.

## How It Works

Ralph uses a **Stop hook** that intercepts your exit attempts. When you try to leave the session:
1. The hook blocks your exit
2. It feeds the same original prompt back to you
3. You see your previous work in files and git commit history
4. You continue iterating until the task is complete

This creates a self-referential feedback loop where each iteration improves upon the last.

## Available Commands

### `/ralph-loop` - Start a Ralph Loop

Start a Ralph loop in your current session:

```bash
/ralph-loop "YOUR TASK PROMPT" --max-iterations <N> --completion-promise "<TEXT>"
```

**Parameters:**
- `PROMPT` (required): Your task description
- `--max-iterations <N>` (optional): Stop after N iterations (recommended: 20-50)
- `--completion-promise "<TEXT>"` (optional): A phrase you'll output when truly done

**Examples:**

Basic usage with iteration limit:
```bash
/ralph-loop "Build a TODO REST API with CRUD operations and tests" --max-iterations 30
```

With completion promise for early exit:
```bash
/ralph-loop "Build a TODO API. Requirements: CRUD endpoints, validation, tests. Output <promise>COMPLETE</promise> when all tests pass." --completion-promise "COMPLETE" --max-iterations 50
```

### `/cancel-ralph` - Cancel Active Loop

Stop the currently running Ralph loop:

```bash
/cancel-ralph
```

This removes the loop state file and allows normal session exit.

## Cross-Platform Support

This plugin works on:
- **Linux** - Uses bash scripts
- **macOS** - Uses bash scripts
- **WSL (Windows Subsystem for Linux)** - Uses bash scripts
- **Windows PowerShell** - Uses PowerShell scripts
- **PowerShell Core** - Uses PowerShell scripts

The plugin automatically detects your platform and runs the appropriate scripts.

## Key Concepts

### Completion Promises

A completion promise is a special marker you output when the task is truly finished:

```
<promise>COMPLETE</promise>
```

**CRITICAL RULES:**
- Only output the promise when the task is **genuinely complete**
- Don't use false promises to escape the loop
- The promise must match exactly what you specified with `--completion-promise`

### Self-Reference Mechanism

Between iterations:
- Your file changes persist
- Git history shows your commits
- You can read your own previous work
- You learn from past mistakes and build incrementally

### Iteration Limits

Always use `--max-iterations` as a safety net:
```bash
--max-iterations 30  # Good default for most tasks
--max-iterations 50  # For complex tasks
```

## Best Practices

### ✅ Good Prompts

**Clear deliverables:**
```
Build a REST API with:
- CRUD endpoints for todos
- Input validation
- Unit tests
- Integration tests
Output <promise>COMPLETE</promise> when all tests pass.
```

**Phased approach:**
```
Phase 1: Set up project structure
Phase 2: Implement CRUD endpoints
Phase 3: Add validation
Phase 4: Write and pass all tests
Output <promise>DONE</promise> when complete.
```

**Test-driven:**
```
Create a calculator library.
1. Write comprehensive tests first
2. Implement features
3. Ensure all tests pass
Output <promise>READY</promise> when test suite is green.
```

### ❌ Bad Prompts

**Too vague:**
```
Make a web app  # What kind? What features?
```

**No completion criteria:**
```
Build something cool  # How do you know when it's done?
```

**Subjective goals:**
```
Make the code better  # Better by what measure?
```

## When to Use Ralph

### ✅ Great For

- **Well-defined tasks** with clear success criteria
- **Greenfield projects** where you can walk away and check back later
- **Test-driven development** (write tests, iterate until they pass)
- **Tasks with automatic verification** (tests, linters, type checkers)
- **Incremental building** where each iteration adds value

### ❌ Not Great For

- **Subjective tasks** requiring human judgment
- **One-shot operations** (file renames, simple refactors)
- **Production debugging** requiring live investigation
- **Tasks with unclear success criteria**
- **Exploratory work** without concrete deliverables

## Workflow Example

1. Start the loop:
```bash
/ralph-loop "Create a todo CLI app with add, list, complete commands. Output <promise>COMPLETE</promise> when working." --completion-promise "COMPLETE" --max-iterations 40
```

2. Ralph iterates:
   - Iteration 1: Set up project structure
   - Iteration 2: Implement 'add' command
   - Iteration 3: Implement 'list' command
   - Iteration 4: Implement 'complete' command
   - Iteration 5: Write tests
   - Iteration 6: Fix failing tests
   - Iteration 7: All tests pass → outputs `<promise>COMPLETE</promise>`

3. Loop automatically stops when promise detected

## Philosophy

- **Iteration > Perfection**: Don't try to get it perfect on the first try
- **Failures Are Data**: Use test failures to guide improvements
- **Operator Skill Matters**: Better prompts = better results
- **Persistence Wins**: Keep iterating until success

## Tips for Success

1. **Start small**: Test Ralph on simple tasks first
2. **Use tests**: Automated verification is key to successful loops
3. **Set realistic limits**: Start with `--max-iterations 20` and adjust
4. **Be specific**: Clear requirements lead to better outcomes
5. **Trust the process**: Let Ralph iterate multiple times before intervening

## Real-World Results

The Ralph technique has been used to:
- Generate 6 complete repositories overnight
- Complete a $50k contract for $297 in API costs
- Create an entire programming language over 3 months
- Build production-ready applications autonomously

## Learn More

For more information about the original Ralph technique:
- [Original Ralph Wiggum Blog Post](https://www.anthropic.com/research/claude-code-ralph)

---

**Remember**: Ralph is a tool for autonomous iteration. Give it clear goals, let it work, and trust the loop! 🔄
