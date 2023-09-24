' Prevent Windows sleep mode.
Set objArgs = WScript.Arguments

hours = 8

If objArgs.Count > 0 Then
    hours = CInt(objArgs.Item(0))
End If
sleepTimeMin = 2
runTimeMin = 60 * hours


Set ws = WScript.CreateObject("WScript.Shell")
WScript.StdOut.WriteLine("Running for " & CStr(hours) & " hours")
sleepTimeMs = 1000 * 60 * sleepTimeMin ' sleep for 2 min
runTimeLeftMs = 1000 * 60 * runTimeMin ' min in ms
minLeft = 0

Do While runTimeLeftMs > 0
    ws.SendKeys("{NUMLOCK}")
    ws.SendKeys("{NUMLOCK}")
    minLeft = runTimeLeftMs / 1000 / 60
    WScript.StdOut.WriteLine "Left: " & CStr(minLeft) & " / " & CStr(runTimeMin) & " min"
    WScript.Sleep(sleepTimeMs)
    runTimeLeftMs = runTimeLeftMs - sleepTimeMs
Loop
