#!/usr/bin/env bash

# Ralph Wiggum Setup Script - Bash version
# Works on: Linux, macOS, WSL

set -e

# Default values
PROMPT=""
MAX_ITERATIONS=""
COMPLETION_PROMISE=""

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --max-iterations)
      MAX_ITERATIONS="$2"
      shift 2
      ;;
    --completion-promise)
      COMPLETION_PROMISE="$2"
      shift 2
      ;;
    *)
      # Collect remaining args as the prompt
      PROMPT="$*"
      break
      ;;
  esac
done

# Validate prompt is provided
if [[ -z "$PROMPT" ]]; then
  echo "Error: No prompt provided." >&2
  echo "" >&2
  echo "Usage: /ralph-loop \"YOUR TASK PROMPT\" [--max-iterations N] [--completion-promise \"TEXT\"]" >&2
  echo "" >&2
  echo "Example:" >&2
  echo "  /ralph-loop \"Build a REST API. Output <promise>COMPLETE</promise> when done.\" --max-iterations 50 --completion-promise \"COMPLETE\"" >&2
  exit 1
fi

# Validate max iterations if provided
if [[ -n "$MAX_ITERATIONS" ]]; then
  if ! [[ "$MAX_ITERATIONS" =~ ^[0-9]+$ ]]; then
    echo "Error: --max-iterations must be a positive number." >&2
    exit 1
  fi
  if [[ "$MAX_ITERATIONS" -lt 1 ]]; then
    echo "Error: --max-iterations must be at least 1." >&2
    exit 1
  fi
fi

# Validate completion promise if provided
if [[ -n "$COMPLETION_PROMISE" ]] && [[ ${#COMPLETION_PROMISE} -lt 2 ]]; then
  echo "Error: --completion-promise must be at least 2 characters." >&2
  exit 1
fi

# Create .claude directory if it doesn't exist
mkdir -p .claude

# Check if a Ralph loop is already active
RALPH_STATE=".claude/ralph-loop.local.md"
if [[ -f "$RALPH_STATE" ]]; then
  CURRENT_ITERATION=$(grep -E "^iteration:" "$RALPH_STATE" | head -n1 | sed 's/iteration:[[:space:]]*//')
  echo "Error: A Ralph loop is already active (iteration $CURRENT_ITERATION)." >&2
  echo "Use /cancel-ralph to cancel it first." >&2
  exit 1
fi

# Create the Ralph state file
cat > "$RALPH_STATE" <<EOF
---
iteration: 0
max_iterations: ${MAX_ITERATIONS:-""}
completion_promise: ${COMPLETION_PROMISE:+"\"$COMPLETION_PROMISE\""}
---

$PROMPT
EOF

# Output success message
echo "✅ Ralph loop initialized!"
echo ""
echo "📋 Configuration:"
echo "   - Starting iteration: 0"
if [[ -n "$MAX_ITERATIONS" ]]; then
  echo "   - Max iterations: $MAX_ITERATIONS"
else
  echo "   - Max iterations: unlimited"
fi
if [[ -n "$COMPLETION_PROMISE" ]]; then
  echo "   - Completion promise: \"$COMPLETION_PROMISE\""
  echo ""
  echo "⚠️  IMPORTANT: Only output <promise>$COMPLETION_PROMISE</promise> when the task is truly complete."
  echo "   False promises will terminate the loop prematurely and waste your work."
else
  echo "   - Completion promise: none (will run until max iterations)"
fi
echo ""
echo "🔄 The loop will start now. When you try to exit, the same prompt will be fed back to you."
echo "   You'll see your previous work in files and git history, allowing iterative improvement."
echo ""
echo "To cancel the loop: /cancel-ralph"
