#Requires AutoHotkey v2.0

#SingleInstance Force  ; Ensures only one instance of the script runs
#NoTrayIcon

LauncherHotkey := "!{Space}" ; Alt+Space
LWin & Space::Send(LauncherHotkey) ; Win+Space

; Hotkey to start GlazeWM
LWin & Enter::ActivateGlazeWM()

ActivateGlazeWM() {
    ; Check if GlazeWM is already running
    if ProcessExist("GlazeWM.exe")
    {
        return ; Do nothing if already running
    }

    glazewmExeFilePath := "C:\Program Files\glzr.io\GlazeWM\glazewm.exe"

    if FileExist(glazewmExeFilePath)
    {
        ; Launch GlazeWM
        Run(glazewmExeFilePath)
    }
    else
    {
        MsgBox("Error: GlazeWM executable path not found.")
        return
    }
}


; Hotkey to minimize the focused window
#m::WinMinimize("A")  ; Minimizes the active window

; Hotkey to fullscreen active window
#f::ToggleFullScreenWindow("A")

ToggleFullScreenWindow(winTitle*) {
    hwnd := WinExist(winTitle*)  ; Get the active window's handle
    if !hwnd {  ; If no window is active, return early
        return
    }

    ; Check if the active window is already maximized
    if (WinGetMinMax(hwnd))
    {
      WinRestore(hwnd) ; Restore the window if already maximized
    }
    else
    {
      WinMaximize(hwnd)
    }
}

; Close active window
#+q::WinClose("A")

#o::CenterWindow("A")

CenterWindow(winTitle*) {
    hwnd := WinExist(winTitle*)
    if !hwnd {  ; If no window is active
        return
    }

    WinGetPos ,, &W, &H, hwnd
    mon := GetNearestMonitorInfo(hwnd)
    WinMove mon.WALeft + mon.WAWidth // 2 - W // 2, mon.WATop + mon.WAHeight // 2 - H // 2,,, hwnd
}

GetNearestMonitorInfo(winTitle*) {
    static MONITOR_DEFAULTTONEAREST := 0x00000002
    hwnd := WinExist(winTitle*)
    hMonitor := DllCall("MonitorFromWindow", "ptr", hwnd, "uint", MONITOR_DEFAULTTONEAREST, "ptr")
    NumPut("uint", 104, MONITORINFOEX := Buffer(104))
    if (DllCall("user32\GetMonitorInfo", "ptr", hMonitor, "ptr", MONITORINFOEX)) {
        Return  { Handle   : hMonitor
                , Name     : Name := StrGet(MONITORINFOEX.ptr + 40, 32)
                , Number   : RegExReplace(Name, ".*(\d+)$", "$1")
                , Left     : L  := NumGet(MONITORINFOEX,  4, "int")
                , Top      : T  := NumGet(MONITORINFOEX,  8, "int")
                , Right    : R  := NumGet(MONITORINFOEX, 12, "int")
                , Bottom   : B  := NumGet(MONITORINFOEX, 16, "int")
                , WALeft   : WL := NumGet(MONITORINFOEX, 20, "int")
                , WATop    : WT := NumGet(MONITORINFOEX, 24, "int")
                , WARight  : WR := NumGet(MONITORINFOEX, 28, "int")
                , WABottom : WB := NumGet(MONITORINFOEX, 32, "int")
                , Width    : Width  := R - L
                , Height   : Height := B - T
                , WAWidth  : WR - WL
                , WAHeight : WB - WT
                , Primary  : NumGet(MONITORINFOEX, 36, "uint")
            }
    }
    throw Error("GetMonitorInfo: " A_LastError, -1)
}

#u::ResizeWindow("A")

ResizeWindow(winTitle*) {
    hwnd := WinExist(winTitle*)  ; Get the active window's handle
    if !hwnd {  ; If no window is active, return early
        return
    }

    WinGetPos ,, &W, &H, hwnd
    mon := GetNearestMonitorInfo(hwnd)

    ; Calculate new window size (70% of monitor size)
    newWidth := mon.WAWidth * 0.85
    newHeight := mon.WAHeight * 0.8

    ; Calculate the new centered position
    newX := mon.WALeft + (mon.WAWidth - newWidth) / 2
    newY := mon.WATop + (mon.WAHeight - newHeight) / 2

    ; Resize and move the active window to the center
    WinMove(newX, newY, newWidth, newHeight, hwnd)
}
