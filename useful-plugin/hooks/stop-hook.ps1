# Ralph Wiggum Stop Hook - PowerShell version
# Works on: Windows PowerShell, PowerShell Core

$ErrorActionPreference = "Stop"

# Check if we're in a Ralph loop
$RalphState = Join-Path ".claude" "ralph-loop.local.md"

if (-not (Test-Path $RalphState)) {
    # No Ralph loop active, allow normal exit
    exit 0
}

try {
    # Read the Ralph state file
    $stateContent = Get-Content $RalphState -Raw

    # Parse YAML frontmatter
    if ($stateContent -match '(?s)iteration:\s*(\d+)') {
        $iteration = [int]$matches[1]
    } else {
        Write-Error "Ralph loop state corrupted (invalid iteration number). Cleaning up."
        Remove-Item $RalphState -Force
        exit 0
    }

    $maxIterations = $null
    if ($stateContent -match 'max_iterations:\s*(\d+)') {
        $maxIterations = [int]$matches[1]
    }

    $completionPromise = $null
    if ($stateContent -match 'completion_promise:\s*"?([^"\r\n]*)"?') {
        $completionPromise = $matches[1]
    }

    # Check if max iterations reached
    if ($null -ne $maxIterations -and $iteration -ge $maxIterations) {
        Write-Host "Ralph loop completed: Maximum iterations ($maxIterations) reached." -ForegroundColor Yellow
        Remove-Item $RalphState -Force
        exit 0
    }

    # Get the last assistant message from the transcript
    $transcriptDir = Join-Path ".claude" "transcript"
    if (Test-Path $transcriptDir) {
        $latestTranscript = Get-ChildItem $transcriptDir -Filter "*.jsonl" |
            Sort-Object LastWriteTime -Descending |
            Select-Object -First 1

        if ($latestTranscript) {
            # Read transcript and extract last assistant message
            $lines = Get-Content $latestTranscript.FullName
            $lastAssistantMessage = $null

            for ($i = $lines.Count - 1; $i -ge 0; $i--) {
                $line = $lines[$i]
                if ($line -match '"role":"assistant"') {
                    # Extract text content from JSON
                    if ($line -match '"text":"((?:[^"\\]|\\.)*)"') {
                        $lastAssistantMessage = $matches[1]
                        # Unescape JSON string
                        $lastAssistantMessage = $lastAssistantMessage -replace '\\n', "`n" -replace '\\t', "`t" -replace '\\"', '"' -replace '\\\\', '\'
                        break
                    }
                }
            }

            # Check for completion promise if set
            if ($completionPromise -and $lastAssistantMessage) {
                $escapedPromise = [regex]::Escape($completionPromise)
                if ($lastAssistantMessage -match "<promise>$escapedPromise</promise>") {
                    Write-Host "Ralph loop completed: Completion promise '$completionPromise' detected." -ForegroundColor Green
                    Remove-Item $RalphState -Force
                    exit 0
                }
            }
        }
    }

    # Increment iteration counter
    $nextIteration = $iteration + 1

    # Update the iteration count in the state file
    $stateContent = $stateContent -replace 'iteration:\s*\d+', "iteration: $nextIteration"
    Set-Content $RalphState -Value $stateContent -NoNewline

    # Extract the original prompt from the state file
    # Everything after the second --- is the prompt
    if ($stateContent -match '(?s)---.*?---\s*(.*)$') {
        $prompt = $matches[1].Trim()
    } else {
        $prompt = ""
    }

    # Block the exit and feed the prompt back
    $response = @{
        decision = "block"
        explanation = "Ralph loop iteration $nextIteration"
        systemMessage = "🔄 Ralph loop iteration $nextIteration`n`n$prompt"
    } | ConvertTo-Json -Compress

    Write-Output $response
}
catch {
    Write-Error "Error in Ralph stop hook: $_"
    exit 1
}
