#!/usr/bin/env bash

# Ralph Wiggum Stop Hook - Bash version
# Works on: Linux, macOS, WSL
# This hook intercepts exit attempts and creates the self-referential loop

set -e

# Check if we're in a Ralph loop
RALPH_STATE=".claude/ralph-loop.local.md"

if [[ ! -f "$RALPH_STATE" ]]; then
  # No Ralph loop active, allow normal exit
  exit 0
fi

# Read the Ralph state file
ITERATION=$(grep -E "^iteration:" "$RALPH_STATE" | head -n1 | sed 's/iteration:[[:space:]]*//')
MAX_ITERATIONS=$(grep -E "^max_iterations:" "$RALPH_STATE" | head -n1 | sed 's/max_iterations:[[:space:]]*//')
COMPLETION_PROMISE=$(grep -E "^completion_promise:" "$RALPH_STATE" | head -n1 | sed 's/completion_promise:[[:space:]]*//' | sed 's/"//g')

# Validate iteration is a number
if ! [[ "$ITERATION" =~ ^[0-9]+$ ]]; then
  echo "Error: Ralph loop state corrupted (invalid iteration number). Cleaning up." >&2
  rm -f "$RALPH_STATE"
  exit 0
fi

# Check if max iterations reached
if [[ -n "$MAX_ITERATIONS" ]] && [[ "$MAX_ITERATIONS" != '""' ]]; then
  if [[ "$ITERATION" -ge "$MAX_ITERATIONS" ]]; then
    echo "Ralph loop completed: Maximum iterations ($MAX_ITERATIONS) reached." >&2
    rm -f "$RALPH_STATE"
    exit 0
  fi
fi

# Get the last assistant message from the transcript
TRANSCRIPT_DIR=".claude/transcript"
if [[ -d "$TRANSCRIPT_DIR" ]]; then
  LATEST_TRANSCRIPT=$(ls -t "$TRANSCRIPT_DIR"/*.jsonl 2>/dev/null | head -n1)

  if [[ -n "$LATEST_TRANSCRIPT" ]]; then
    # Extract last assistant message with proper JSON parsing
    LAST_MESSAGE=$(tac "$LATEST_TRANSCRIPT" | grep -m1 '"role":"assistant"' | perl -0777 -ne 'while (/"text":"((?:[^"\\]|\\.)*)"/g) { print $1 }' | perl -pe 's/\\n/\n/g; s/\\t/\t/g; s/\\"/"/g; s/\\\\/\\/g')

    # Check for completion promise if set
    if [[ -n "$COMPLETION_PROMISE" ]] && [[ "$COMPLETION_PROMISE" != '""' ]]; then
      # Use perl for reliable regex matching
      if echo "$LAST_MESSAGE" | perl -ne "exit 1 unless /<promise>\Q$COMPLETION_PROMISE\E<\/promise>/"; then
        echo "Ralph loop completed: Completion promise '$COMPLETION_PROMISE' detected." >&2
        rm -f "$RALPH_STATE"
        exit 0
      fi
    fi
  fi
fi

# Increment iteration counter
NEXT_ITERATION=$((ITERATION + 1))

# Update the iteration count in the state file
# Use perl for safe in-place editing that preserves the file structure
perl -i -pe "s/^iteration: .*/iteration: $NEXT_ITERATION/" "$RALPH_STATE"

# Extract the original prompt from the state file
# Everything after the frontmatter (---) is the prompt
PROMPT=$(awk '/^---$/ && ++count == 2 {flag=1; next} flag' "$RALPH_STATE")

# Block the exit and feed the prompt back
cat <<EOF
{
  "decision": "block",
  "explanation": "Ralph loop iteration $NEXT_ITERATION",
  "systemMessage": "🔄 Ralph loop iteration $NEXT_ITERATION\n\n$PROMPT"
}
EOF
