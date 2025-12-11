# Carter Marketplace 🚀

A curated marketplace of Claude Code plugins designed to supercharge your development workflow with production-ready agents, skills, commands, and MCP servers. No configuration needed - these best practices work out of the box!

## 🎯 What is Carter Marketplace?

Carter Marketplace is a collection of pre-configured Claude Code plugins that extend Claude's capabilities with specialized tools, agents, and integrations. Each plugin is designed to solve real development problems with minimal setup.

## 📦 Available Plugins

### useful-plugin

A comprehensive plugin that brings together essential development tools for everyday coding tasks. This plugin includes specialized agents, creative skills, efficient commands, and powerful MCP server integrations.

## ✨ Features

### 🤖 Specialized Agents

Agents are autonomous sub-processes that handle complex, multi-step tasks with specialized capabilities.

#### **code-review**
Perform thorough code reviews with comprehensive analysis:
- **Code Quality Analysis**: Structure, organization, code smells, anti-patterns, and maintainability
- **Bug Detection**: Runtime errors, logic errors, null pointer dereferences, race conditions, error handling
- **Security Review**: OWASP Top 10 vulnerabilities, injection flaws (SQL, XSS, command injection), authentication/authorization logic, insecure cryptography, hardcoded secrets
- **Performance Analysis**: Bottlenecks, inefficient algorithms, unnecessary computations, database query optimization
- **Best Practices**: Error handling, test coverage, documentation, API design, dependency management
- **Architecture Review**: Design patterns, separation of concerns, module boundaries, scalability

**Use Cases:**
- Pull request reviews
- Security audits
- Identifying bugs and potential issues
- Code standards enforcement
- Refactoring guidance

#### **chrome-devtools**
Real-time browser debugging and inspection powered by Chrome DevTools MCP:
- **DOM & Element Inspection**: Snapshot page structure, inspect properties, identify layout issues
- **JavaScript Evaluation**: Execute code in browser context, test functions interactively, debug client-side logic
- **Network Analysis**: Inspect HTTP requests/responses, examine headers and payloads, debug API calls
- **Console Debugging**: Review logs, warnings, errors, capture stack traces
- **Browser Automation**: Navigate pages, fill forms, upload files, handle dialogs, emulate devices
- **Performance Profiling**: Start/stop traces, analyze Core Web Vitals, generate performance insights

**Use Cases:**
- Frontend debugging in live browsers
- Testing JavaScript in browser context
- Analyzing network requests and responses
- Automating browser interactions
- Performance profiling

### 🎨 Creative Skills

Skills provide specialized capabilities and domain knowledge for specific tasks.

#### **frontend-design**
Create distinctive, production-grade frontend interfaces that avoid generic AI aesthetics:
- **Bold Design Thinking**: Choose extreme aesthetic directions (brutally minimal, maximalist chaos, retro-futuristic, organic/natural, luxury/refined, playful, editorial, brutalist, art deco, industrial, etc.)
- **Typography Excellence**: Distinctive, beautiful font choices that elevate aesthetics beyond generic fonts
- **Cohesive Color & Theme**: CSS variables for consistency with dominant colors and sharp accents
- **Motion & Animation**: CSS-only solutions, Motion library for React, scroll-triggered effects, staggered reveals
- **Spatial Composition**: Unexpected layouts, asymmetry, overlap, diagonal flow, generous negative space
- **Visual Details**: Gradient meshes, noise textures, geometric patterns, layered transparencies, dramatic shadows, custom cursors, grain overlays

**Design Principles:**
- Production-grade, functional code
- Visually striking and memorable interfaces
- Cohesive aesthetic point-of-view
- Context-specific character (no generic templates)
- Match implementation complexity to aesthetic vision

**Use Cases:**
- Building web components, pages, or applications
- Creating unique, polished interfaces
- Avoiding generic "AI slop" designs
- Production-ready frontend code

### ⚡ Efficient Commands

Commands are lightweight, single-purpose operations for common tasks.

#### **/commit**
Create git commits following Angular convention:
- Uses Haiku model for speed and efficiency
- Analyzes current git status and diff
- Generates meaningful commit messages
- Stages and commits changes in a single operation
- Follows Angular commit message convention

**Permissions:**
- `git status`: Check repository state
- `git add`: Stage changes
- `git commit`: Create commits

### 🔌 MCP Server Integrations

Model Context Protocol (MCP) servers provide external tool integrations.

#### **chrome-devtools MCP**
Provides all Chrome DevTools capabilities:
- Direct browser automation and inspection
- Real-time DOM and network analysis
- JavaScript evaluation in browser context
- Performance tracing and profiling

**Command:** `npx -y chrome-devtools-mcp`

#### **context7 MCP**
Retrieve up-to-date documentation and code examples for any library:
- Resolve library names to Context7-compatible IDs
- Fetch current documentation with code examples
- Access API references and conceptual guides
- Support for versioned documentation

**Command:** `npx -y @upstash/context7-mcp`

## 🚀 Getting Started

### Installation

1. Clone the marketplace:
```bash
git clone git@github.com:bjzgcai/claude-marketplace.git
claude
```

2. Add the marketplace to Claude Code:
```
/plugin marketplace add ./claude-marketplace
```

3. Install the plugin you want:
```
/plugin install useful-plugin@claude-marketplace
```

4. Select "Install now" when prompted.

5. Restart Claude Code to activate the plugin.

6. Verify installation by checking available commands:
```
/help
```
You should see the new commands, agents, and skills from the plugin listed.

7. Start using the features! Try the `/commit` command, invoke agents like `code-review`, or use skills like `frontend-design`.

### Update Plugins

quickest way: 
```
claude plugin disable useful-plugin && claude plugin enable useful-plugin && claude
```



### Using Plugins

Plugins in this marketplace follow the Claude Code plugin structure:

```
plugin-name/
├── .claude-plugin/
│   └── plugin.json          # Plugin metadata
├── .mcp.json                # MCP server configurations
├── agents/                  # Specialized agents
│   ├── agent-name.md
│   └── ...
├── skills/                  # Creative skills
│   ├── skill-name.md
│   └── ...
└── commands/               # Quick commands
    ├── command-name.md
    └── ...
```

### Plugin Structure

Each plugin includes:

- **plugin.json**: Metadata (name, version, author, description)
- **.mcp.json**: MCP server configurations for external tool integrations
- **agents/**: Markdown files defining specialized agents
- **skills/**: Markdown files defining creative capabilities
- **commands/**: Markdown files defining quick operations

## 📋 Plugin Details

### useful-plugin Configuration

**Plugin Info:**
- **Name:** useful-plugin
- **Version:** 1.0.0
- **Author:** Carter
- **Description:** A useful plugin to learn the basics

**Contents:**
- 2 Agents (code-review, chrome-devtools)
- 1 Skill (frontend-design)
- 1 Command (commit)
- 2 MCP Servers (chrome-devtools, context7)

## 🤝 Contributing

Want to add your own plugin to the marketplace?

1. Fork this repository
2. Create a new plugin directory following the structure above
3. Add your plugin to `.claude-plugin/marketplace.json`
4. Submit a pull request

## 📝 License

See individual plugin licenses for details.

## 🙏 Credits

Marketplace maintained by ZGC Carter

Built with [Claude Code](https://claude.com/claude-code) and the [Claude Agent SDK](https://github.com/anthropics/claude-agent-sdk)

---

**Note:** This marketplace showcases best practices for Claude Code plugins. All features are production-ready and work out of the box!
