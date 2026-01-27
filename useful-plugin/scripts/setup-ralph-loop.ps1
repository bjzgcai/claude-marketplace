# Ralph Wiggum Setup Script - PowerShell version
# Works on: Windows PowerShell, PowerShell Core

param(
    [Parameter(ValueFromRemainingArguments)]
    [string[]]$Arguments
)

$ErrorActionPreference = "Stop"

# Default values
$Prompt = ""
$MaxIterations = $null
$CompletionPromise = $null

# Parse arguments
$i = 0
$promptStarted = $false
while ($i -lt $Arguments.Count) {
    $arg = $Arguments[$i]

    if (-not $promptStarted) {
        switch ($arg) {
            "--max-iterations" {
                if ($i + 1 -lt $Arguments.Count) {
                    $MaxIterations = $Arguments[$i + 1]
                    $i += 2
                } else {
                    Write-Error "--max-iterations requires a value"
                    exit 1
                }
                continue
            }
            "--completion-promise" {
                if ($i + 1 -lt $Arguments.Count) {
                    $CompletionPromise = $Arguments[$i + 1]
                    $i += 2
                } else {
                    Write-Error "--completion-promise requires a value"
                    exit 1
                }
                continue
            }
            default {
                $promptStarted = $true
            }
        }
    }

    if ($promptStarted) {
        if ($Prompt) {
            $Prompt += " "
        }
        $Prompt += $arg
        $i++
    }
}

# Validate prompt is provided
if (-not $Prompt) {
    Write-Host "Error: No prompt provided.`n" -ForegroundColor Red
    Write-Host "Usage: /ralph-loop `"YOUR TASK PROMPT`" [--max-iterations N] [--completion-promise `"TEXT`"]`n"
    Write-Host "Example:"
    Write-Host "  /ralph-loop `"Build a REST API. Output <promise>COMPLETE</promise> when done.`" --max-iterations 50 --completion-promise `"COMPLETE`""
    exit 1
}

# Validate max iterations if provided
if ($MaxIterations) {
    try {
        $maxIter = [int]$MaxIterations
        if ($maxIter -lt 1) {
            Write-Error "--max-iterations must be at least 1"
            exit 1
        }
    }
    catch {
        Write-Error "--max-iterations must be a positive number"
        exit 1
    }
}

# Validate completion promise if provided
if ($CompletionPromise -and $CompletionPromise.Length -lt 2) {
    Write-Error "--completion-promise must be at least 2 characters"
    exit 1
}

# Create .claude directory if it doesn't exist
$claudeDir = ".claude"
if (-not (Test-Path $claudeDir)) {
    New-Item -ItemType Directory -Path $claudeDir | Out-Null
}

# Check if a Ralph loop is already active
$RalphState = Join-Path $claudeDir "ralph-loop.local.md"
if (Test-Path $RalphState) {
    $content = Get-Content $RalphState -Raw
    if ($content -match 'iteration:\s*(\d+)') {
        $currentIteration = $matches[1]
        Write-Host "Error: A Ralph loop is already active (iteration $currentIteration)." -ForegroundColor Red
        Write-Host "Use /cancel-ralph to cancel it first."
        exit 1
    }
}

# Create the Ralph state file
$stateContent = @"
---
iteration: 0
max_iterations: $MaxIterations
completion_promise: $(if ($CompletionPromise) { "`"$CompletionPromise`"" } else { "" })
---

$Prompt
"@

Set-Content -Path $RalphState -Value $stateContent -NoNewline

# Output success message
Write-Host "✅ Ralph loop initialized!`n" -ForegroundColor Green
Write-Host "📋 Configuration:"
Write-Host "   - Starting iteration: 0"
if ($MaxIterations) {
    Write-Host "   - Max iterations: $MaxIterations"
} else {
    Write-Host "   - Max iterations: unlimited"
}
if ($CompletionPromise) {
    Write-Host "   - Completion promise: `"$CompletionPromise`"`n"
    Write-Host "⚠️  IMPORTANT: Only output <promise>$CompletionPromise</promise> when the task is truly complete." -ForegroundColor Yellow
    Write-Host "   False promises will terminate the loop prematurely and waste your work."
} else {
    Write-Host "   - Completion promise: none (will run until max iterations)"
}
Write-Host "`n🔄 The loop will start now. When you try to exit, the same prompt will be fed back to you."
Write-Host "   You'll see your previous work in files and git history, allowing iterative improvement.`n"
Write-Host "To cancel the loop: /cancel-ralph"
