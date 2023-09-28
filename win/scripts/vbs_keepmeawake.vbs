' Prevent Windows sleep mode.
Set objArgs = WScript.Arguments

hours = 8
minutes = 0
i = 0
    If objArgs.Count = 1 Then hours = CInt(objArgs.Item(0))
    If objArgs.Count = 2 Then 
        hours = CInt(objArgs.Item(0))
        minutes = CInt(objArgs.Item(1))
    End If

sleepTimeMin = 2
mlSec = 1000 ' change to 1 to make it fast
minToSec = 60
runTimeMin = 60 * hours + minutes

Set ws = WScript.CreateObject("WScript.Shell")
WScript.StdOut.WriteLine("Running for " & CStr(hours) & " hours")
sleepTimeMs = mlSec * minToSec * sleepTimeMin ' sleep for 2 min
runTimeLeftMs = mlSec * minToSec * runTimeMin ' min in milliseconds
minLeft = 0

Do While runTimeLeftMs > 0
    ws.SendKeys("{NUMLOCK}")
    ws.SendKeys("{NUMLOCK}")
    WScript.StdOut.Write Chr(27) & "[34A"
    WScript.StdOut.Write Chr(27) & "[2J"
    minLeft = runTimeLeftMs / mlSec / minToSec
    WScript.StdOut.WriteLine "Left: " & CStr(minLeft) & " / " & CStr(runTimeMin) & " min"
    WScript.Sleep(sleepTimeMs)
    runTimeLeftMs = runTimeLeftMs - sleepTimeMs
Loop

WScript.StdOut.WriteLine "Done!"