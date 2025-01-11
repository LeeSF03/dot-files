#SingleInstance Force  ; Ensures only one instance of the script runs
#NoTrayIcon

; Hotkey to minimize the focused window
#m::
{   ; Win + M
    WinMinimize("A")  ; Minimizes the active window
}

LauncherHotkey := "!{Space}" ; Alt+Space
LWin & Space::Send(LauncherHotkey) ; Win+Space

#Enter::
{
    ; Check if GlazeWM is already running
    if ProcessExist("GlazeWM.exe")
    {
        return ; Do nothing if already running
    }

    ; Launch GlazeWM
    Run("C:\Program Files\glzr.io\GlazeWM\glazewm.exe")
}
