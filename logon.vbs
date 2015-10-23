On Error Resume Next 'Continues past errors
Set objShell = CreateObject("WScript.Shell") 
Set fso = CreateObject("Scripting.FileSystemObject")

'===== Declare constants =====
'===== pathToFile has to be changed to the user directory path
UserName = objShell.ExpandEnvironmentStrings("%USERNAME%") 'gets the users username
pathToFile = "display\store\directory.txt"
wasFound = false
row = 0
Set dict = CreateObject("Scripting.Dictionary")
Set file = fso.OpenTextFile(pathToFile, 1)

Do Until file.AtEndOfStream
    line = file.Readline
    dict.Add row, line
    row = row + 1
Loop

file.Close

For Each ln in dict.Items
    If ln = UserName Then
        wasFound = true
    End If
Next

If wasFound Then
WScript.Quit()

else
' ===== Run HTA File to show user the EULA =====
Call DisableTaskMgr 

dim strComputer 
dim wmiNS 
dim wmiQuery 
dim objWMIService 
dim colItems 
dim objItem 
Dim strOUT 
 
strComputer = "." 
wmiNS = "\root\cimv2" 
wmiQuery = "Select processID from win32_process where name = 'explorer.exe'" 
 
Set objWMIService = GetObject("winmgmts:\\" & strComputer & wmiNS) 
Set colItems = objWMIService.ExecQuery(wmiQuery) 
 
For Each objItem in colItems 'Stops normal log in procedure
    	objItem.terminate(1)
    subLaunch     
Next 
 
Sub subLaunch 
Dim objShell 
Dim strProg 
 
strProg = "display\EULA.hta" 'Path to EULA hta file 'URL MUST BE CHANGED
Const MaxWindow = 3 
Const blnWait = True 
 
Set objShell = CreateObject("wscript.shell") 
objShell.Run strProg,maxWindow,blnWait 'Runs the hta file in full screen mode
 
subcreateProcess 
 
End Sub  
 
Sub subcreateProcess 
Dim obj
Set obj = objWMIService.Get("win32_process") 
obj.create("explorer.exe") 
End sub

' ===== DisableTaskMgr =====
sub DisableTaskMgr
Dim WshShell,System
System="HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System\"
Set WshShell=CreateObject("WScript.Shell")
Wshshell.RegWrite System, "REG_SZ"
WshShell.RegWrite System &"\DisableTaskMgr", 1, "REG_DWORD"
end sub

End If

WScript.Quit()