#Requires AutoHotKey 2.0.10

; #Warn All          	; Enable all warnings to assist with detecting common errors ; #Warn All, Off
#SingleInstance force	; Reloads script without dialog box
#NoTrayIcon

#Include %A_scriptDir%\gVar\var.ahk	; Global vars

#Include <Array>

dbg 	:= 0	; Level of debug verbosity (0-none)
dbgT	:= 2	; Timer for dbg messages (seconds)

#Include %A_scriptDir%\HideCursorWhenTyping.ahk	; Hide mouse pointer while typing
; ^+r::Reload ;[^⇧r] VK52
if (isStandAlone := (A_ScriptFullPath = A_LineFile)) {
  ; TraySetIcon("./img/🖰 hide on 🖮.ico",0)
}
