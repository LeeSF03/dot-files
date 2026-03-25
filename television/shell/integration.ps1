
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'tv' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'tv'
        for ($i = 1; $i -lt $commandElements.Count; $i++) {
            $element = $commandElements[$i]
            if ($element -isnot [StringConstantExpressionAst] -or
                $element.StringConstantType -ne [StringConstantType]::BareWord -or
                $element.Value.StartsWith('-') -or
                $element.Value -eq $wordToComplete) {
                break
        }
        $element.Value
    }) -join ';'

    $completions = @(switch ($command) {
        'tv' {
            [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Source command to use for the current channel.')
            [CompletionResult]::new('--source-command', '--source-command', [CompletionResultType]::ParameterName, 'Source command to use for the current channel.')
            [CompletionResult]::new('--source-display', '--source-display', [CompletionResultType]::ParameterName, 'Source display template to use for the current channel.')
            [CompletionResult]::new('--source-output', '--source-output', [CompletionResultType]::ParameterName, 'Source output template to use for the current channel.')
            [CompletionResult]::new('--source-entry-delimiter', '--source-entry-delimiter', [CompletionResultType]::ParameterName, 'The delimiter byte to use for splitting the source''s command output into entries.')
            [CompletionResult]::new('-p', '-p', [CompletionResultType]::ParameterName, 'Preview command to use for the current channel.')
            [CompletionResult]::new('--preview-command', '--preview-command', [CompletionResultType]::ParameterName, 'Preview command to use for the current channel.')
            [CompletionResult]::new('--preview-header', '--preview-header', [CompletionResultType]::ParameterName, 'Preview header template')
            [CompletionResult]::new('--preview-footer', '--preview-footer', [CompletionResultType]::ParameterName, 'Preview footer template')
            [CompletionResult]::new('--preview-offset', '--preview-offset', [CompletionResultType]::ParameterName, 'A preview line number offset template to use to scroll the preview to for each entry.')
            [CompletionResult]::new('--preview-border', '--preview-border', [CompletionResultType]::ParameterName, 'Sets the preview panel border type.')
            [CompletionResult]::new('--preview-padding', '--preview-padding', [CompletionResultType]::ParameterName, 'Sets the preview panel padding.')
            [CompletionResult]::new('--preview-size', '--preview-size', [CompletionResultType]::ParameterName, 'Percentage of the screen to allocate to the preview panel (1-99).')
            [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'Input text to pass to the channel to prefill the prompt.')
            [CompletionResult]::new('--input', '--input', [CompletionResultType]::ParameterName, 'Input text to pass to the channel to prefill the prompt.')
            [CompletionResult]::new('--input-header', '--input-header', [CompletionResultType]::ParameterName, 'Input field header template.')
            [CompletionResult]::new('--input-prompt', '--input-prompt', [CompletionResultType]::ParameterName, 'Input prompt string')
            [CompletionResult]::new('--input-position', '--input-position', [CompletionResultType]::ParameterName, 'Input bar position.')
            [CompletionResult]::new('--input-border', '--input-border', [CompletionResultType]::ParameterName, 'Sets the input panel border type.')
            [CompletionResult]::new('--input-padding', '--input-padding', [CompletionResultType]::ParameterName, 'Sets the input panel padding.')
            [CompletionResult]::new('--results-border', '--results-border', [CompletionResultType]::ParameterName, 'Sets the results panel border type.')
            [CompletionResult]::new('--results-padding', '--results-padding', [CompletionResultType]::ParameterName, 'Sets the results panel padding.')
            [CompletionResult]::new('--layout', '--layout', [CompletionResultType]::ParameterName, 'Layout orientation for the UI.')
            [CompletionResult]::new('--ui-scale', '--ui-scale', [CompletionResultType]::ParameterName, 'Change the display size in relation to the available area.')
            [CompletionResult]::new('--height', '--height', [CompletionResultType]::ParameterName, 'Height in lines for non-fullscreen mode.')
            [CompletionResult]::new('--width', '--width', [CompletionResultType]::ParameterName, 'Width in columns for non-fullscreen mode.')
            [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'The application''s tick rate.')
            [CompletionResult]::new('--tick-rate', '--tick-rate', [CompletionResultType]::ParameterName, 'The application''s tick rate.')
            [CompletionResult]::new('--watch', '--watch', [CompletionResultType]::ParameterName, 'Watch mode: reload the source command every N seconds.')
            [CompletionResult]::new('--autocomplete-prompt', '--autocomplete-prompt', [CompletionResultType]::ParameterName, 'Try to guess the channel from the provided input prompt.')
            [CompletionResult]::new('-k', '-k', [CompletionResultType]::ParameterName, 'Keybindings to override the default keybindings.')
            [CompletionResult]::new('--keybindings', '--keybindings', [CompletionResultType]::ParameterName, 'Keybindings to override the default keybindings.')
            [CompletionResult]::new('--expect', '--expect', [CompletionResultType]::ParameterName, 'Keys that can be used to confirm the current selection in addition to the default ones (typically `enter`).')
            [CompletionResult]::new('--config-file', '--config-file', [CompletionResultType]::ParameterName, 'Provide a custom configuration file to use.')
            [CompletionResult]::new('--cable-dir', '--cable-dir', [CompletionResultType]::ParameterName, 'Provide a custom cable directory to use.')
            [CompletionResult]::new('--ansi', '--ansi', [CompletionResultType]::ParameterName, 'Whether tv should extract and parse ANSI style codes from the source command output.')
            [CompletionResult]::new('--no-sort', '--no-sort', [CompletionResultType]::ParameterName, 'Disable automatic sorting of entries based on match quality.')
            [CompletionResult]::new('--cache-preview', '--cache-preview', [CompletionResultType]::ParameterName, 'Whether to cache the preview command output for each entry.')
            [CompletionResult]::new('--no-preview', '--no-preview', [CompletionResultType]::ParameterName, 'Disable the preview panel entirely on startup.')
            [CompletionResult]::new('--hide-preview', '--hide-preview', [CompletionResultType]::ParameterName, 'Hide the preview panel on startup (only works if feature is enabled).')
            [CompletionResult]::new('--show-preview', '--show-preview', [CompletionResultType]::ParameterName, 'Show the preview panel on startup (only works if feature is enabled).')
            [CompletionResult]::new('--preview-word-wrap', '--preview-word-wrap', [CompletionResultType]::ParameterName, 'Enables preview panel word wrap.')
            [CompletionResult]::new('--hide-preview-scrollbar', '--hide-preview-scrollbar', [CompletionResultType]::ParameterName, 'Hide preview panel scrollbar.')
            [CompletionResult]::new('--no-status-bar', '--no-status-bar', [CompletionResultType]::ParameterName, 'Disable the status bar entirely on startup.')
            [CompletionResult]::new('--hide-status-bar', '--hide-status-bar', [CompletionResultType]::ParameterName, 'Hide the status bar on startup (only works if feature is enabled).')
            [CompletionResult]::new('--show-status-bar', '--show-status-bar', [CompletionResultType]::ParameterName, 'Show the status bar on startup (only works if feature is enabled).')
            [CompletionResult]::new('--no-remote', '--no-remote', [CompletionResultType]::ParameterName, 'Disable the remote control.')
            [CompletionResult]::new('--hide-remote', '--hide-remote', [CompletionResultType]::ParameterName, 'Hide the remote control on startup (only works if feature is enabled).')
            [CompletionResult]::new('--show-remote', '--show-remote', [CompletionResultType]::ParameterName, 'Show the remote control on startup (only works if feature is enabled).')
            [CompletionResult]::new('--no-help-panel', '--no-help-panel', [CompletionResultType]::ParameterName, 'Disable the help panel entirely on startup.')
            [CompletionResult]::new('--hide-help-panel', '--hide-help-panel', [CompletionResultType]::ParameterName, 'Hide the help panel on startup (only works if feature is enabled).')
            [CompletionResult]::new('--show-help-panel', '--show-help-panel', [CompletionResultType]::ParameterName, 'Show the help panel on startup (only works if feature is enabled).')
            [CompletionResult]::new('--inline', '--inline', [CompletionResultType]::ParameterName, 'Use all available empty space at the bottom of the terminal as an inline interface.')
            [CompletionResult]::new('--exact', '--exact', [CompletionResultType]::ParameterName, 'Use substring matching instead of fuzzy matching.')
            [CompletionResult]::new('--select-1', '--select-1', [CompletionResultType]::ParameterName, 'Automatically select and output the first entry if there is only one entry.')
            [CompletionResult]::new('--take-1', '--take-1', [CompletionResultType]::ParameterName, 'Take the first entry from the list after the channel has finished loading.')
            [CompletionResult]::new('--take-1-fast', '--take-1-fast', [CompletionResultType]::ParameterName, 'Take the first entry from the list as soon as it becomes available.')
            [CompletionResult]::new('--global-history', '--global-history', [CompletionResultType]::ParameterName, 'Use global history instead of channel-specific history.')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('-V', '-V ', [CompletionResultType]::ParameterName, 'Print version')
            [CompletionResult]::new('--version', '--version', [CompletionResultType]::ParameterName, 'Print version')
            [CompletionResult]::new('list-channels', 'list-channels', [CompletionResultType]::ParameterValue, 'Lists the available channels')
            [CompletionResult]::new('init', 'init', [CompletionResultType]::ParameterValue, 'Initializes shell completion ("tv init zsh")')
            [CompletionResult]::new('update-channels', 'update-channels', [CompletionResultType]::ParameterValue, 'Downloads the latest collection of channel prototypes from github and saves them to the local configuration directory')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'tv;list-channels' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'tv;init' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'tv;update-channels' {
            [CompletionResult]::new('--force', '--force', [CompletionResultType]::ParameterName, 'Force update on unsupported and already existing channels')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'tv;help' {
            [CompletionResult]::new('list-channels', 'list-channels', [CompletionResultType]::ParameterValue, 'Lists the available channels')
            [CompletionResult]::new('init', 'init', [CompletionResultType]::ParameterValue, 'Initializes shell completion ("tv init zsh")')
            [CompletionResult]::new('update-channels', 'update-channels', [CompletionResultType]::ParameterValue, 'Downloads the latest collection of channel prototypes from github and saves them to the local configuration directory')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'tv;help;list-channels' {
            break
        }
        'tv;help;init' {
            break
        }
        'tv;help;update-channels' {
            break
        }
        'tv;help;help' {
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}
# Television PowerShell Integration
# Requires PSReadLine module (usually included by default in PowerShell 5.1+)

function Get-AvailableSpaceBelowPrompt {
    $windowHeight = [Console]::WindowHeight
    $windowTop = [Console]::WindowTop
    $cursorY = [Console]::CursorTop
    $spaceBelow = $windowHeight - ($cursorY - $windowTop)
    return $spaceBelow
}

function Invoke-TvSmartAutocomplete {
    <#
    .SYNOPSIS
        Smart autocomplete using television (tv) based on current command context
    #>
    [CmdletBinding()]
    param()

    # Get the current command line and cursor position
    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    # Get the part before cursor (left buffer)
    $lhs = $line.Substring(0, $cursor)
    $rhs = $line.Substring($cursor)

    # Separate lhs into words to get the last word
    $words = $lhs -split '\s+'
    # Handle trailing space - if last char is space, we're starting a new word
    if ($lhs.Length -gt 0 -and $lhs[-1] -match '\s') {
        $lastWord = ""
    } else {
        $lastWord = if ($words.Count -gt 0) { $words[-1] } else { "" }
    }

    # Call tv with autocomplete prompt
    try {
        # Debug file for cursor position tracking
        $debugFile = Join-Path $env:TEMP "tv-pwsh-debug.log"

        # Save the original prompt position
        $originalPromptY = [Console]::CursorTop
        $savedCursorX = [Console]::CursorLeft

        # skip a line to make room for TV's UI
        [Console]::WriteLine()

        # how much space left down
        $spaceBelow = Get-AvailableSpaceBelowPrompt
        $minTVHeight = 15
        $tvScrollLines = 0
        if ($spaceBelow -lt $minTVHeight) {
            # Not enough space below, scroll up
            $tvScrollLines = $minTVHeight - $spaceBelow
        }

        # Escape arguments properly for Windows command-line parsing
        # Backslashes before quotes need to be escaped to prevent them from escaping the quote
        $lhsEscaped = $lhs -replace '\\+$', '$0$0'  # Double trailing backslashes
        $lastWordEscaped = $lastWord -replace '\\+$', '$0$0'  # Double trailing backslashes

        # Use .NET Process class for explicit stream control
        # This ensures stdin comes from console, stdout is captured, and stderr (TUI) goes to console
        $psi = New-Object System.Diagnostics.ProcessStartInfo
        $psi.FileName = "tv"
        # $psi.Arguments = "--no-status-bar --inline --autocomplete-prompt `"$lhsEscaped`" --input `"$lastWordEscaped`""
        $psi.Arguments = "--no-status-bar --inline --autocomplete-prompt `"$lhsEscaped`""
        $psi.UseShellExecute = $false
        $psi.RedirectStandardOutput = $true
        $psi.RedirectStandardError = $false  # Let TUI render to console
        $psi.RedirectStandardInput = $false  # Let process use console directly for input
        $psi.WorkingDirectory = $PWD.Path  # Use current PowerShell working directory

        $process = New-Object System.Diagnostics.Process
        $process.StartInfo = $psi
        $process.Start() | Out-Null

        # Read stdout
        $output = $process.StandardOutput.ReadToEnd().Trim()
        $process.WaitForExit()

        # Restore cursor to original position
        [Console]::CursorTop = $originalPromptY - $tvScrollLines
        [Console]::CursorLeft = $savedCursorX

        if ($output) {
            # TV returns the full completed path, so we need to remove the lastWord from lhs
            # to avoid duplication
            $lhsWithoutLastWord = if ($lastWord.Length -gt 0) {
                $lhs.Substring(0, $lhs.Length - $lastWord.Length)
            } else {
                $lhs
            }

            # Replace the buffer with the completion
            $newLine = $lhsWithoutLastWord + $output + $rhs
            [Microsoft.PowerShell.PSConsoleReadLine]::Replace(0, $line.Length, $newLine)
        }
    }
    catch {
        # Print error if tv is not available or errors occur
        Write-Debug "TV autocomplete failed: $_"
    }
}

function Invoke-TvShellHistory {
    <#
    .SYNOPSIS
        Search shell history using television (tv)
    #>
    [CmdletBinding()]
    param()

    # Get the current command line and cursor position
    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    # Get the part before cursor as search context
    $currentPrompt = $line.Substring(0, $cursor)

    # Call tv with history channel
    try {
        # Debug file for cursor position tracking
        $debugFile = Join-Path $env:TEMP "tv-pwsh-debug.log"

        # Save the original prompt position before any scrolling
        $originalPromptY = [Console]::CursorTop
        $savedCursorX = [Console]::CursorLeft

        # skip a line to make room for TV's UI
        [Console]::WriteLine()

        # how much space left down
        $spaceBelow = Get-AvailableSpaceBelowPrompt
        $minTVHeight = 15
        $tvScrollLines = 0
        if ($spaceBelow -lt $minTVHeight) {
            # Not enough space below, scroll up
            $tvScrollLines = $minTVHeight - $spaceBelow
        }

        # Escape arguments properly for Windows command-line parsing
        $currentPromptEscaped = $currentPrompt -replace '\\+$', '$0$0'  # Double trailing backslashes

        # Use .NET Process class for explicit stream control
        $psi = New-Object System.Diagnostics.ProcessStartInfo
        $psi.FileName = "tv"
        $psi.Arguments = "pwsh-history --inline --no-status-bar --input `"$currentPromptEscaped`""
        $psi.UseShellExecute = $false
        $psi.RedirectStandardOutput = $true
        $psi.RedirectStandardError = $false  # Let TUI render to console
        $psi.RedirectStandardInput = $false  # Let process use console directly for input
        $psi.WorkingDirectory = $PWD.Path  # Use current PowerShell working directory

        $process = New-Object System.Diagnostics.Process
        $process.StartInfo = $psi
        $process.Start() | Out-Null

        # Read stdout (the selected result)
        $output = $process.StandardOutput.ReadToEnd().Trim()
        $process.WaitForExit()

        # Restore cursor to original position
        [Console]::CursorTop = $originalPromptY - $tvScrollLines
        [Console]::CursorLeft = $savedCursorX

        if ($output) {
            # Replace entire line with selected history
            [Microsoft.PowerShell.PSConsoleReadLine]::Replace(0, $line.Length, $output)
        }
    }
    catch {
        # Print error if tv is not available or errors occur
        Write-Debug "TV shell history failed: $_"
    }
}

# Set up key bindings
Set-PSReadLineKeyHandler -Chord 'Ctrl+t' -ScriptBlock {
    Invoke-TvSmartAutocomplete
}

Set-PSReadLineKeyHandler -Chord 'Ctrl+r' -ScriptBlock {
    Invoke-TvShellHistory
}

