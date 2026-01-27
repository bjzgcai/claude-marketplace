#!/usr/bin/env bash

# Useful Plugin Installation Verification Script
# Run this to verify that the Ralph Wiggum plugin is correctly installed

set -e

echo "🔍 Verifying Useful Plugin Installation..."
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get plugin root directory
PLUGIN_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "📁 Plugin directory: $PLUGIN_ROOT"
echo ""

# Track issues
ISSUES=0

# Function to check file exists
check_file() {
    local file="$1"
    local description="$2"

    if [ -f "$PLUGIN_ROOT/$file" ]; then
        echo -e "${GREEN}✓${NC} $description"
        return 0
    else
        echo -e "${RED}✗${NC} $description - NOT FOUND: $file"
        ISSUES=$((ISSUES + 1))
        return 1
    fi
}

# Function to check directory exists
check_dir() {
    local dir="$1"
    local description="$2"

    if [ -d "$PLUGIN_ROOT/$dir" ]; then
        echo -e "${GREEN}✓${NC} $description"
        return 0
    else
        echo -e "${RED}✗${NC} $description - NOT FOUND: $dir"
        ISSUES=$((ISSUES + 1))
        return 1
    fi
}

# Function to check file is executable
check_executable() {
    local file="$1"
    local description="$2"

    if [ -x "$PLUGIN_ROOT/$file" ]; then
        echo -e "${GREEN}✓${NC} $description"
        return 0
    else
        echo -e "${YELLOW}⚠${NC} $description - NOT EXECUTABLE (may need: chmod +x $file)"
        return 1
    fi
}

echo "Checking Core Files:"
echo "-------------------"
check_file ".claude-plugin/plugin.json" "Plugin configuration"
check_file "README.md" "Documentation"
echo ""

echo "Checking Commands:"
echo "-----------------"
check_file "commands/ralph-loop.md" "Ralph Loop command"
check_file "commands/cancel-ralph.md" "Cancel Ralph command"
check_file "commands/ralph-help.md" "Ralph Help command"
check_file "commands/commit.md" "Commit command"
echo ""

echo "Checking Skills:"
echo "---------------"
check_file "skills/frontend-design.md" "Frontend Design skill"
echo ""

echo "Checking Agents:"
echo "---------------"
check_file "agents/code-review.md" "Code Review agent"
check_file "agents/chrome-devtools.md" "Chrome DevTools agent"
echo ""

echo "Checking Hooks (Bash):"
echo "---------------------"
check_file "hooks/stop-hook" "Platform wrapper"
check_file "hooks/stop-hook.sh" "Bash stop hook"
check_executable "hooks/stop-hook" "Platform wrapper is executable"
check_executable "hooks/stop-hook.sh" "Bash stop hook is executable"
echo ""

echo "Checking Hooks (PowerShell):"
echo "---------------------------"
check_file "hooks/stop-hook.ps1" "PowerShell stop hook"
echo ""

echo "Checking Scripts (Bash):"
echo "-----------------------"
check_file "scripts/setup-ralph-loop.sh" "Bash setup script"
check_executable "scripts/setup-ralph-loop.sh" "Bash setup script is executable"
echo ""

echo "Checking Scripts (PowerShell):"
echo "-----------------------------"
check_file "scripts/setup-ralph-loop.ps1" "PowerShell setup script"
echo ""

echo "Checking Documentation:"
echo "----------------------"
check_file "QUICKSTART.md" "Quick Start Guide"
check_file "RALPH_EXAMPLES.md" "Ralph Examples"
check_file "CHANGELOG.md" "Changelog"
echo ""

echo "Checking Directories:"
echo "--------------------"
check_dir ".claude-plugin" "Plugin config directory"
check_dir "commands" "Commands directory"
check_dir "hooks" "Hooks directory"
check_dir "scripts" "Scripts directory"
check_dir "skills" "Skills directory"
check_dir "agents" "Agents directory"
echo ""

# Platform detection
echo "Platform Detection:"
echo "------------------"
if [ -n "$BASH_VERSION" ]; then
    echo -e "${GREEN}✓${NC} Bash detected: $BASH_VERSION"
    echo "  → Will use bash scripts (.sh)"
elif [ -n "$ZSH_VERSION" ]; then
    echo -e "${GREEN}✓${NC} Zsh detected: $ZSH_VERSION"
    echo "  → Will use bash scripts (.sh)"
fi

if command -v pwsh &> /dev/null; then
    PWSH_VERSION=$(pwsh -Version 2>&1 | head -n1)
    echo -e "${GREEN}✓${NC} PowerShell Core detected: $PWSH_VERSION"
    echo "  → PowerShell scripts (.ps1) available"
elif command -v powershell &> /dev/null; then
    echo -e "${GREEN}✓${NC} Windows PowerShell detected"
    echo "  → PowerShell scripts (.ps1) available"
fi
echo ""

# Summary
echo "======================================"
if [ $ISSUES -eq 0 ]; then
    echo -e "${GREEN}✓ Installation verified successfully!${NC}"
    echo ""
    echo "🚀 You're ready to use Ralph Wiggum!"
    echo ""
    echo "Quick Start:"
    echo "  1. Read QUICKSTART.md for a 5-minute intro"
    echo "  2. Try: /ralph-loop \"Create a Python file with add function and test\" --max-iterations 10"
    echo "  3. Get help: /ralph-help"
else
    echo -e "${RED}✗ Found $ISSUES issue(s)${NC}"
    echo ""
    echo "Please fix the issues above and run this script again."
    echo ""
    echo "Common fixes:"
    echo "  - Make scripts executable: chmod +x hooks/*.sh scripts/*.sh"
    echo "  - Ensure all files were copied correctly"
fi
echo "======================================"

exit $ISSUES
