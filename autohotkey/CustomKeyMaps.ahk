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
    newWidth := mon.WAWidth * 0.8
    newHeight := mon.WAHeight * 0.8

    ; Calculate the new centered position
    newX := mon.WALeft + (mon.WAWidth - newWidth) / 2
    newY := mon.WATop + (mon.WAHeight - newHeight) / 2

    ; Resize and move the active window to the center
    WinMove(newX, newY, newWidth, newHeight, hwnd)
}

#!o:: ; LAlt + LWin + Space (Left modifiers)
{
    Win := WinGetID("A")  ; Get active window
    if !Win
        return

    ; Get current position and size
    WinGetPos(&x, &y, &w, &h, Win)

    ; Increase size
    w += 10
    h += 10
    x -=5
    y -=5

    ; Apply new size
    WinMove(x, y, w, h, Win)
}

#!+o:: ; LAlt + LWin + Space (Left modifiers)
{
    Win := WinGetID("A")  ; Get active window
    if !Win
        return

    ; Get current position and size
    WinGetPos(&x, &y, &w, &h, Win)

    ; Increase size
    w += -10
    h += -10
    x += 5
    y += 5

    ; Apply new size
    WinMove(x, y, w, h, Win)
}

; #+f::FullScreen("A")
;
; ; Toggle fullscreen
; ; uses same parameters as WinExist
; FullScreen(winTitle*) {
;     static MONITOR_DEFAULTTONEAREST := 0x00000002
;     static WS_CAPTION               := 0x00C00000
;     static WS_SIZEBOX               := 0x00040000
;     static Border                   := WS_CAPTION|WS_SIZEBOX
;     static IsBorderless             := "AHK:BorderlessFullscreen"
;     static IsMaxed                  := "AHK:FullscreenPrevMax"
;     static propX                    := "AHK:FullscreenPrevX"
;     static propY                    := "AHK:FullscreenPrevY"
;     static propW                    := "AHK:FullscreenPrevW"
;     static propH                    := "AHK:FullscreenPrevH"
;
;     if !hwnd := WinExist(winTitle*)
;         return 0
;     if WinGetClass(hwnd) = "CabinetWClass" && WinGetProcessName(hwnd) = "explorer.exe" {
;         ControlSend "{F11}", hwnd
;         return
;     }
;     if !GetProp(hwnd, IsBorderless) { ; If not borderless
;         GetWindowPlacement(hwnd, &X, &Y, &W, &H)
;         SetProp(hwnd, propX, X, propY, Y, propW, W, propH, H)
;         if maxState := WinGetMinMax(hwnd) = 1 ? true : false { ; Save max state
;             WinGetPos(&X, &Y, &W, &H, hwnd)
;             SetWindowPlacement(hwnd, X, Y, W, H) ; Make transition smoother between restoring and fullscreen
;             WinRestore hwnd ; Restore window if maximized, some windows can't be moved if maximized
;         }
;         SetProp(hwnd, IsMaxed, maxState) ; Save minmax state
;         WinSetStyle("-" Border, hwnd) ; Remove caption and sizebox from window
;         NumPut("uint", 40, monInfo := Buffer(40))
;         DllCall("GetMonitorInfo"
;             , "ptr", DllCall("MonitorFromWindow", "ptr", hwnd, "uint", MONITOR_DEFAULTTONEAREST) ; hMonitor from nearest monitor to window
;             , "ptr", monInfo)
;         WinMove(
;             monLeft   := NumGet(monInfo, 4, "int"),
;             monTop    := NumGet(monInfo, 8, "int"),
;             monWidth  := (monRight    := NumGet(monInfo, 12, "Int") - monLeft),
;             monHeight := (monBottom   := NumGet(monInfo, 16, "int") - monTop),
;             hwnd)
;         SetProp(hwnd, IsBorderless, 1)
;     } else { ; Restore borders and original position
;         WinSetStyle "+" Border, hwnd
;         X := GetProp(hwnd, propX), Y := GetProp(hwnd, propY), W := GetProp(hwnd, propW), H := GetProp(hwnd, propH)
;         if GetProp(hwnd, IsMaxed)
;             WinMaximize hwnd
;         SetWindowPlacement(hwnd, X, Y, W, H)
;         SetProp(hwnd, IsBorderless, 0)
;     }
;
;     SetProp(win, propValue*) {
;         if propValue.Length & 1
;             throw Error("Invalid number of parameters.", -1)
;         loop propValue.Length // 2 {
;             prop := propValue[A_Index*2 - 1], value := propValue[A_Index*2]
;             DllCall("SetProp", "ptr", win, "str", prop, "ptr", value)
;         }
;     }
;
;     GetProp(win, name) => DllCall("GetProp", "ptr", WinExist(win), "str", name)
;
;     GetWindowPlacement(hwnd, &X, &Y, &W, &H) {
;         NumPut("uint", 44, WP := Buffer(44, 0))
;         DllCall("GetWindowPlacement", "Ptr", hwnd, "Ptr", WP)
;         X := NumGet(WP, 28, "Int")
;         Y := NumGet(WP, 32, "Int")
;         W := NumGet(WP, 36, "Int") - X
;         H := NumGet(WP, 40, "Int") - Y
;     }
;
;     SetWindowPlacement(hwnd, X, Y, W, H) {
;         NumPut("uint", 44, WP := Buffer(44, 0))
;         DllCall("GetWindowPlacement", "Ptr", hwnd, "Ptr", WP)
;         NumPut("uint", 4, WP, 4) ; WPF_ASYNCWINDOWPLACEMENT
;         NumPut("int", X, WP, 28)
;         NumPut("int", Y, WP, 32)
;         NumPut("int", W + X, WP, 36)
;         NumPut("int", H + Y, WP, 40)
;         DllCall("SetWindowPlacement", "ptr", hwnd, "ptr", WP)
;     }
; }
