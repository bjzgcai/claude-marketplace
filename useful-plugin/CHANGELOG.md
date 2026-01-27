# Changelog

All notable changes to the Useful Plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-01-27

### Added - Ralph Wiggum Integration

#### Core Features
- **Ralph Wiggum Technique**: Complete implementation of continuous self-referential AI loops
- **Cross-Platform Support**: Full compatibility with Linux, macOS, WSL, Windows PowerShell, and PowerShell Core
- **Automatic Platform Detection**: Plugin automatically selects bash or PowerShell implementation

#### Commands
- **`/ralph-loop`**: Start a Ralph loop with configurable options
  - `--max-iterations N`: Set maximum iteration limit
  - `--completion-promise "TEXT"`: Define exit condition
  - Automatic platform detection and script selection

- **`/cancel-ralph`**: Cancel active Ralph loop
  - Reports current iteration number
  - Cleans up state files

- **`/ralph-help`**: Comprehensive Ralph documentation
  - Technique explanation
  - Usage examples
  - Best practices
  - When to use (and not use) Ralph

#### Scripts - Bash Implementations
- **`hooks/stop-hook.sh`**: Stop hook for Unix-like systems (Linux, macOS, WSL)
  - Intercepts exit attempts
  - Checks iteration limits
  - Detects completion promises
  - Feeds prompts back to Claude

- **`scripts/setup-ralph-loop.sh`**: Setup script for Unix-like systems
  - Argument parsing and validation
  - State file creation
  - Configuration display

#### Scripts - PowerShell Implementations
- **`hooks/stop-hook.ps1`**: Stop hook for Windows PowerShell/PowerShell Core
  - Complete parity with bash version
  - Native PowerShell JSON handling
  - Windows-compatible file operations

- **`scripts/setup-ralph-loop.ps1`**: Setup script for PowerShell
  - PowerShell parameter handling
  - Native .NET integration
  - Cross-platform PowerShell support

#### Infrastructure
- **`hooks/stop-hook`**: Platform detection wrapper
  - Automatically detects bash/zsh vs PowerShell
  - Routes to appropriate implementation
  - Fallback handling

#### Documentation
- **`README.md`**: Complete plugin documentation
  - Ralph technique overview
  - Installation instructions
  - Usage examples
  - Cross-platform compatibility notes
  - Real-world results and case studies

- **`QUICKSTART.md`**: Fast-start guide
  - 2-minute first loop example
  - 5-minute realistic example
  - Common commands reference
  - Troubleshooting guide

- **`RALPH_EXAMPLES.md`**: Comprehensive examples
  - 8 detailed use cases
  - Beginner to advanced examples
  - Best practices and tips
  - Common pitfalls to avoid
  - Cross-platform notes

- **`CHANGELOG.md`**: Version history (this file)

### Changed

- **Plugin Version**: Updated from 1.0.0 to 2.0.0
- **Plugin Description**: Enhanced to reflect Ralph Wiggum integration
- **Directory Structure**: Added `hooks/` and `scripts/` directories

### Technical Details

#### State Management
- State file: `.claude/ralph-loop.local.md`
- YAML frontmatter for configuration
- Markdown body for prompt storage
- Atomic updates to prevent corruption

#### Platform Detection
- Checks `$BASH_VERSION` and `$ZSH_VERSION` for Unix shells
- Checks `$PSModulePath` for PowerShell
- Falls back to bash if uncertain
- Supports both PowerShell 5.1 (Windows) and PowerShell Core 7+ (cross-platform)

#### Hook Mechanism
- Intercepts stop events via Claude Code hook system
- Returns JSON response with `decision: "block"`
- Includes `systemMessage` with next iteration prompt
- Preserves conversation context across iterations

### Compatibility

#### Tested Platforms
- ✅ Linux (Ubuntu, Debian, Fedora, Arch)
- ✅ macOS (Intel and Apple Silicon)
- ✅ WSL 1 and WSL 2
- ✅ Windows 10/11 PowerShell 5.1
- ✅ PowerShell Core 7+ (all platforms)

#### Requirements
- Claude Code CLI (latest version)
- Bash 4.0+ (for Unix-like systems) OR PowerShell 5.1+ (for Windows)
- Git (for version control features)
- Standard Unix tools: grep, sed, awk, perl (for bash version)

### Migration Guide

If upgrading from 1.0.0:

1. **No breaking changes** - Existing commands, skills, and agents unchanged
2. **New commands available** - `/ralph-loop`, `/cancel-ralph`, `/ralph-help`
3. **New capabilities** - Can now use continuous iteration loops
4. **No configuration needed** - Platform detection is automatic

### Credits

- Original Ralph Wiggum technique: **Daisy Hollman** (daisy@anthropic.com)
- Cross-platform adaptation: **Carter**
- Based on: [claude-code/plugins/ralph-wiggum](https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum)

## [1.0.0] - 2026-01-26

### Added

- Initial plugin structure
- `/commit` command for git workflow
- `frontend-design` skill
- `code-review` agent
- `chrome-devtools` agent with MCP integration
- Basic plugin configuration

---

## Future Roadmap

Potential future enhancements:

### Planned for 2.1.0
- [ ] Ralph loop pause/resume functionality
- [ ] Progress visualization/dashboard
- [ ] Loop metrics and analytics
- [ ] Custom hook configurations
- [ ] Multi-loop orchestration

### Ideas for 3.0.0
- [ ] Ralph loop templates for common tasks
- [ ] Integration with CI/CD pipelines
- [ ] Loop sharing and collaboration features
- [ ] Advanced completion conditions (not just promises)
- [ ] Ralph loop recorder/replay

---

For more information, see:
- [README.md](README.md) - Full documentation
- [QUICKSTART.md](QUICKSTART.md) - Quick start guide
- [RALPH_EXAMPLES.md](RALPH_EXAMPLES.md) - Examples and patterns
