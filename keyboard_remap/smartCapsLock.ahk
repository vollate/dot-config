#Requires AutoHotkey v2.0

*CapsLock:: {
    Send "{Blind}{Ctrl down}"
}

*CapsLock up:: {
    Send "{Blind}{Ctrl up}"

    if (A_PriorKey = "CapsLock") {
        Send "{Esc}"
    }
}
