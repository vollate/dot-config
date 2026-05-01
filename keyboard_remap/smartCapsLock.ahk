#Requires AutoHotkey v2.0

SetCapsLockState "AlwaysOff"

*CapsLock:: {
    Send "{Blind}{Ctrl down}"
}

*CapsLock up:: {
    Send "{Blind}{Ctrl up}"

    if (A_PriorKey = "CapsLock") {
        Send "{Esc}"
    }
}

; Right Ctrl <-> Right Alt
*RControl::Send "{Blind}{RAlt down}"
*RControl up::Send "{Blind}{RAlt up}"

*RAlt::Send "{Blind}{RControl down}"
*RAlt up::Send "{Blind}{RControl up}"
