' Prevent Windows sleep mode.
sleepTimeMin = 2
runTimeMin = 360

Set ws = WScript.CreateObject("WScript.Shell")
sleepTimeMs = 1000 * 60 * sleepTimeMin ' sleep for 2 min
runTimeLeftMs = 1000 * 60 * runTimeMin ' min in ms

Do While runTimeLeftMs > 0
    ws.SendKeys("{NUMLOCK}")
    ws.SendKeys("{NUMLOCK}")
    WScript.Sleep(sleepTimeMs)
    runTimeLeftMs = runTimeLeftMs - sleepTimeMs
Loop
