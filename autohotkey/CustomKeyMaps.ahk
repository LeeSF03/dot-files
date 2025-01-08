#SingleInstance Force  ; Ensures only one instance of the script runs
#NoTrayIcon

; Hotkey to minimize the focused window
#m:: {   ; Ctrl + Win + M
    WinMinimize("A")  ; Minimizes the active window
}

LauncherHotkey := "!{Space}" ; Alt+Space
LWin & Space::Send(LauncherHotkey) ; Win+Space
