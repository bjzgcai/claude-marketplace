# Useful Plugin - Enhanced with Ralph Wiggum

A comprehensive Claude Code plugin featuring the Ralph Wiggum technique for continuous self-referential AI loops, plus custom commands, skills, and agents.

## 🚀 Features

### Ralph Wiggum Technique

The Ralph Wiggum technique enables continuous, iterative AI development through self-referential loops. Claude Code repeatedly receives the same prompt, seeing its previous work in files and git history, and iterates until task completion.

**Key Benefits:**
- 🔄 Autonomous iteration without manual intervention
- 📈 Incremental improvement through self-reference
- ✅ Automatic verification via tests and completion criteria
- 💰 Cost-effective for complex tasks
- 🌍 **Cross-platform support** (Linux, macOS, WSL, Windows)

### Commands

- **`/ralph-loop`** - Start a Ralph loop with configurable iteration limits and completion criteria
- **`/cancel-ralph`** - Cancel an active Ralph loop
- **`/ralph-help`** - Comprehensive guide to the Ralph technique
- **`/commit`** - Enhanced git commit workflow

### Skills

- **`frontend-design`** - Frontend design assistance

### Agents

- **`code-review`** - Automated code review agent
- **`chrome-devtools`** - Chrome DevTools integration

### MCP Integration

Includes Model Context Protocol (MCP) configuration for extended capabilities.

## 🖥️ Cross-Platform Compatibility

This plugin is fully compatible with:

- ✅ **Linux** - Native bash support
- ✅ **macOS** - Native bash support
- ✅ **WSL (Windows Subsystem for Linux)** - Native bash support
- ✅ **Windows PowerShell** - Native PowerShell support
- ✅ **PowerShell Core** - Cross-platform PowerShell support

The plugin automatically detects your platform and uses the appropriate implementation (bash or PowerShell).

## 📦 Installation

1. Clone or download this plugin
2. Place it in your Claude Code plugins directory
3. Restart Claude Code or reload plugins

## 🎯 Quick Start with Ralph

### Basic Example

```bash
/ralph-loop "Create a Python calculator with add, subtract, multiply, divide functions and comprehensive tests" --max-iterations 30
```

### Advanced Example with Completion Promise

```bash
/ralph-loop "Build a REST API for managing tasks. Requirements: CRUD endpoints, input validation, error handling, unit tests, integration tests. Output <promise>COMPLETE</promise> when all tests pass." --completion-promise "COMPLETE" --max-iterations 50
```

### Canceling a Loop

```bash
/cancel-ralph
```

### Getting Help

```bash
/ralph-help
```

## 📚 Ralph Usage Guide

### Command Syntax

```bash
/ralph-loop "YOUR TASK" [OPTIONS]
```

**Options:**
- `--max-iterations N` - Maximum number of iterations (recommended: 20-50)
- `--completion-promise "TEXT"` - Exit phrase for early termination

### Best Practices

#### ✅ Do

- **Be specific** about requirements and deliverables
- **Use completion promises** for early exit when goals are met
- **Set iteration limits** as a safety net
- **Include tests** for automatic verification
- **Use phased approaches** for complex tasks

#### ❌ Don't

- Use vague or subjective goals
- Output false completion promises to escape the loop
- Skip iteration limits on exploratory tasks
- Use for one-shot operations that don't benefit from iteration

### Example Prompts

**Test-Driven Development:**
```bash
/ralph-loop "Create a todo list CLI app with TypeScript. Requirements:
1. Commands: add, list, complete, delete
2. Data persistence with JSON file
3. Write comprehensive tests first
4. Implement features to pass tests
Output <promise>READY</promise> when all tests pass." --completion-promise "READY" --max-iterations 40
```

**Phased Approach:**
```bash
/ralph-loop "Build a blog API:
Phase 1: Project setup with Express and TypeScript
Phase 2: Implement CRUD endpoints
Phase 3: Add authentication
Phase 4: Write tests and fix issues
Output <promise>DONE</promise> when complete." --completion-promise "DONE" --max-iterations 50
```

## 🔧 How It Works

1. **Start**: You run `/ralph-loop` with your task prompt
2. **Work**: Claude Code works on the task
3. **Exit Attempt**: When Claude tries to exit, the stop hook intercepts it
4. **Loop Back**: The same prompt is fed back to Claude
5. **Iterate**: Claude sees previous work in files and git history
6. **Complete**: Loop exits when completion promise is detected or max iterations reached

## 🎓 When to Use Ralph

### Great For ✅

- Well-defined projects with clear success criteria
- Test-driven development workflows
- Greenfield projects where you can "set and forget"
- Tasks with automatic verification (tests, linters)
- Building MVPs or prototypes autonomously

### Not Great For ❌

- Subjective tasks requiring human judgment
- Simple one-off operations
- Production debugging requiring live investigation
- Tasks with unclear or evolving requirements
- Exploratory work without concrete deliverables

## 📊 Real-World Results

The Ralph technique has demonstrated remarkable results:

- 🏆 Generated **6 complete repositories** overnight during Y Combinator hackathon testing
- 💵 Completed a **$50k contract** for just **$297** in API costs
- 🔨 Created an **entire programming language** over 3 months
- 🚀 Built multiple **production-ready applications** autonomously

## 🛠️ Advanced Configuration

### State File

Ralph uses `.claude/ralph-loop.local.md` to track state:

```markdown
---
iteration: 5
max_iterations: 30
completion_promise: "COMPLETE"
---

Your original task prompt goes here...
```

### Stop Hook

The stop hook intercepts exit attempts and:
1. Checks iteration limits
2. Searches for completion promises in output
3. Increments iteration counter
4. Feeds the original prompt back to Claude

### Platform Detection

The plugin automatically detects your environment:
- Checks for bash/zsh shells → uses `.sh` scripts
- Checks for PowerShell → uses `.ps1` scripts
- Falls back to bash if uncertain

## 🤝 Contributing

Contributions welcome! Feel free to:
- Report bugs
- Suggest features
- Submit pull requests
- Share your Ralph success stories

## 📝 License

MIT License - See LICENSE file for details

## 👤 Author

**Carter**
- Enhanced with Ralph Wiggum technique
- Cross-platform PowerShell support
- Additional custom commands and agents

## 🙏 Credits

- Original Ralph Wiggum technique by **Daisy Hollman** (daisy@anthropic.com)
- Based on the official Claude Code plugin: [ralph-wiggum](https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum)

## 🔗 Resources

- [Claude Code Documentation](https://github.com/anthropics/claude-code)
- [Ralph Wiggum Original Plugin](https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum)
- [Model Context Protocol (MCP)](https://modelcontextprotocol.io/)

---

**Happy coding with Ralph! 🎉**

Remember: Iteration > Perfection. Let Ralph do the work! 🔄
