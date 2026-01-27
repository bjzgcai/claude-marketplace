---
description: "Cancel active Ralph Wiggum loop"
allowed-tools: ["Bash(test -f .claude/ralph-loop.local.md:*)", "Bash(rm .claude/ralph-loop.local.md)", "Bash(Remove-Item .claude/ralph-loop.local.md:*)", "Read(.claude/ralph-loop.local.md)"]
hide-from-slash-command-tool: "true"
---

# Cancel Ralph

To cancel the Ralph loop:

1. Check if `.claude/ralph-loop.local.md` exists using Bash:
   - On Unix-like systems (Linux, macOS, WSL): `test -f .claude/ralph-loop.local.md && echo "EXISTS" || echo "NOT_FOUND"`
   - On PowerShell: `if (Test-Path .claude/ralph-loop.local.md) { "EXISTS" } else { "NOT_FOUND" }`

2. **If NOT_FOUND**: Say "No active Ralph loop found."

3. **If EXISTS**:
   - Read `.claude/ralph-loop.local.md` to get the current iteration number from the `iteration:` field
   - Remove the file:
     - On Unix-like systems: `rm .claude/ralph-loop.local.md`
     - On PowerShell: `Remove-Item .claude/ralph-loop.local.md -Force`
   - Report: "Cancelled Ralph loop (was at iteration N)" where N is the iteration value
