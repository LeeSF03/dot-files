# run script to temp fix screen reader message
& "$PSScriptRoot\run.ps1"

# figure a way to make this work on windows
# C:\Users\shuen\.config\powershell\powershell_profile.ps1

$Env:COLORTERM = 'truecolor'

# Env vars for yazi
$Env:YAZI_FILE_ONE = 'C:\Program Files\Git\usr\bin\file.exe'
$Env:YAZI_CONFIG_HOME = 'C:\Users\shuen\.config\yazi'

# Env vars for fzf
$ENV:FZF_DEFAULT_COMMAND = 'fd --type file --hidden --exclude .git --no-ignore'
$ENV:FZF_DEFAULT_OPTS = @"
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
--color=selected-bg:#45475a
--multi
--bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down `
--preview 'bat --style numbers,changes --color=always --theme=CatppuccinMocha --line-range=:100 {} || eza -T --level 2 --colour=always --icons=always {2}'
"@

# Env vars for bat
$Env:BAT_CONFIG_PATH = 'C:\Users\shuen\.config\bat\bat.conf'
$Env:BAT_CONFIG_DIR = 'C:\Users\shuen\.config\bat'

# Env vars for eza
$Env:EZA_CONFIG_DIR = 'C:\Users\shuen\.config\eza'

# Env vars for zoxide
$Env:_ZO_ECHO = 1
$Env:_ZO_FZF_OPTS = @"
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
--color=selected-bg:#45475a
--multi
--height 40% `
--layout reverse `
--border
--delimiter '\t' `
--bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down `
--preview 'eza -T --level 2 --colour=always --icons=always {2}' `
--preview-window 'right:35%'
"@

# Env vars for oh-my-posh
$Env:VIRTUAL_ENV_DISABLE_PROMPT = 1

# Env vars for lazygit
$Env:CONFIG_DIR = "C:\Users\shuen\.config\lazygit"

# Env vars for glazewm config path
$Env:GLAZEWM_CONFIG_DIR = "C:\Users\shuen\.config\glazewm\config.yaml"

# Set-Alias
Set-Alias cat bat
Set-Alias du dust

# remove default alias cd
Remove-Item alias:cd -Force

# Set-Alias for zoxide
Set-Alias cd z
Set-Alias cdi zi

Set-Alias ls eza

# Set-Alias for sd
# Set-Alias sed sd

# Functions alias for ls
function ll {
  eza -aalhSm --git --git-repos --git-repos-no-status --colour=always --icons=always --hyperlink --total-size --group-directories-first --total-size $args
}

# yazi shell wrapper https://yazi-rs.github.io/docs/quick-start
function y {
  $tmp = [System.IO.Path]::GetTempFileName()
  yazi $args --cwd-file="$tmp"
  $cwd = Get-Content -Path $tmp
  if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
    Set-Location -LiteralPath $cwd
  }
  Remove-Item -Path $tmp
}

# Functions alias for fastfetch
function ff {
  param (
    [string]$agent,
    [switch]$clear,
    [switch]$h
  )

  $helpMessage = @"
Usage: ff [agent] [-h]

agent  Valorant agent name
-h     Show help
"@

  if ($h) {
    Write-Output $helpMessage
    return
  }
  $agents = @("chamber", "clove", "fade", "iso", "jett", "neon", "omen", "phoenix", "reyna", "sage", "viper", "yoru", "cypher", "sova", "raze", "killjoy", "brimstone", "deadlock", "tejo", "gecko", "vyse", "kayo")

  $logo_root = "C:\Users\shuen\.config\fastfetch\images"

  if ($agent -and $agents -contains $agent) {
    $selected_agent_image = "$agent.png"
  }
  else {
    $selected_agent_image = ($agents | Get-Random) + ".png"
  }

  $logo_path = Join-Path -Path $logo_root -ChildPath $selected_agent_image

  if ($clear) {
    clear
  }

  fastfetch `
    --logo-type iterm `
    --logo "$logo_path" `
    --logo-width 20 --logo-height 10 `
    --logo-padding-right 3 --logo-padding-top 4 --logo-padding-left 3
}


# Functions alias for fzf integraion with vscode and yazi
function fz {
  param (
    [switch]$y,
    [switch]$c,
    [switch]$b,
    [switch]$h
  )
  if ($h) {
    Write-Output "
Usage: fz [-y] [-c] [-b] [-h]

-y     Open in yazi
-c     Open in VS Code
-b     Preview with bat
-h     Show help
"
    return
  }
  $file = $(fzf)
  if ($null -ne $file) {
    $cwd = $(Get-Location)
    $path = "$cwd\$file"
    if ($y) {
      Write-Output "Opening $path in yazi"
      $target_dir = $(Split-Path -Path $file)
      z $target_dir
      y
    }
    elseif ($c) {
      Write-Output "Opening $path in VS Code"
      code $path
    }
    elseif ($b) {
      bat $path
    }
    else {
      Write-Output $(Get-Item $path)
    }
  }
}

# Functions alias for fzf integration with ripgrep and vscode
function frg {
  param (
    [switch]$h
  )
  if ($h) {
    Write-Output "
Usage: frg <search term> [-h]

-h     Show help
"
    return
  }
  $search = $args[0]

  if (!$search) {
    $search = ""
  }
  $rg_prefix = "rg --column --line-number --no-heading --color=always --smart-case "
  fzf --ansi `
    --color "hl:-1:underline,hl+:-1:underline:reverse" `
    --bind "ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down" `
    --bind "start:reload:$rg_prefix || true" `
    --bind "change:reload:$rg_prefix {q} || true" `
    --bind "enter:become(code -g {1}:{2})" `
    --delimiter : `
    --preview "bat --color always {1} --theme=CatppuccinMocha --highlight-line {2}" `
    --preview-window '+{2}+3/3,~3'
}

# Functions alias for fzf integration with ripgrep and sed
function fsr {
  param (
    [switch]$h
  )
  if ($h) {
    Write-Output "
Usage: frg <before> <after> [-h]

-h     Show help
"
    return
  }
  $before = $args[0]
  $after = $args[1]
  rg --ignore-case --color always --line-number --no-heading $before |
  fzf --ansi `
    --color "hl:-1:underline,hl+:-1:underline:reverse" `
    --delimiter ':' `
    --bind "ctrl-r:execute(sed -i {2}'s/$before/$after/gi' {1})+reload(rg --ignore-case --color always --line-number --no-heading $before),ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down" `
    --preview "bat --color always {1} --theme=CatppuccinMocha --highlight-line {2}" `
    --preview-window '+{2}+3/3,~3'
}

# Functions alias for fzf integration with zoxide
function fcd {
  param (
    [switch]$y,
    [switch]$c,
    [switch]$r,
    [switch]$h
  )
  if ($h) {
    Write-Output "
Usage: fcd [-y] [-c] [-h]

-y     Open in yazi
-c     Open in VS Code
-r     Open directory in fzf
-h     Show help
"
    return
  }

  $dir = fd --max-depth 1 --type directory --follow --hidden --exclude .git |
  fzf --prompt 'Directory> ' `
    --header-first `
    --preview 'eza -aT --level 2 --colour=always --icons=always {}' `
    --bind "ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"

  if ($null -ne $dir) {
    if ($y) {
      z $dir
      y
    }
    elseif ($c) {
      code $dir
    }
    else {
      z $dir
    }
  }
}

# Functions alias for tml
function clk {
  $colors = @("blue", "cyan", "green", "red", "yellow", "magenta")
  $color = $colors | Get-Random

  tml clock -s false -d true --color=$color
}

# Functions alias for sptlrx
function lrx {
  $colors = @("#7287fd", "#94e2d5", "#a6e3a1", "#b4befe", "#f9e2af", "#eba0ac", "#f5c2e7", "#cba6f7")
  $color = $colors | Get-Random

  sptlrx --current "bold,underline,$color" --before "faint,$color" --after "104,faint"
}

# Functions alias for onefetch
function gitfetch {
  onefetch --text-colors 4 5 7 5 7 7 --no-color-palette --nerd-fonts $args
}

function gf {
  gitfetch
}

#Functions for spotify_player
function sply {
  spotify_player $args
}

#Functions for git log --all --decorate --oneline --graph
function glog {
  git log --all --decorate --oneline --graph
}

#Functions for Get-Command
function which {
  param (
    [switch]$f,
    [switch]$h
  )
  if ($h) {
    Write-Output "
Usage: which [-f] <command>

-f     Show full command
-h     Show help
"
    return
  }

  $stat = Get-Command $args
  if ($null -ne $stat) {
    if ($f) {
      Write-Output $stat
    }
    else {
      Write-Output $stat.Source
    }
  }
  else {
    Write-Output "Command not found"
  }
}

# Functions for lauching dooit
function todo {
  if ($args) {
    dooit $args
    return
  }
  dooit -c 'C:\Users\shuen\.config\dooit\dooit.py'
}

# Functions for launching hoyoplay
function hoyo {
  & "C:\Program Files\HoYoPlay\launcher.exe"
}


# Functions for launching RecycleBinFolder
function trash {
  start shell:RecycleBinFolder
}

function docker-desktop {
  & "C:\Program Files\Docker\Docker\Docker Desktop.exe"
}

# Initialize oh-my-posh
oh-my-posh init pwsh --config "C:\Users\shuen\.config\oh-my-posh\themes\catppuccin_mocha.omp.json" | Invoke-Expression

# Initialize zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# run fastfetch if not in vscode or nvim
if ($env:TERM_PROGRAM -ne 'vscode' -and -not $env:NVIM) {
  ff
}
