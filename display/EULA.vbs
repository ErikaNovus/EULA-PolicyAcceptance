On Error Resume Next

Call EnableTaskMgr
Version = "V1.0"

'------------------------------EnableTaskMgr---------------------------------------------------
sub EnableTaskMgr
Dim WshShell,System
System="HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System\"
Set WshShell=CreateObject("WScript.Shell")
Wshshell.RegWrite System, "REG_SZ"
WshShell.RegWrite System &"\DisableTaskMgr", 0, "REG_DWORD"
end sub

'------------------------------Open users.txt and update---------------------------------------
' Set objShell = CreateObject("WScript.Shell") 
' UserName = objShell.ExpandEnvironmentStrings("%USERNAME%")
' Set objFSO = CreateObject("Scripting.FileSystemObject")
' Set objFile = objFSO.OpenTextFile("store\users.txt", 8, True)

' ObjFile.WriteLine(UserName & "," & Now & "," & Version)
' objFile.Close

'-----------------------------Create new .csv for user----------------------------------------
Set objShell = CreateOBject("WScript.Shell")
UserName = objShell.ExpandEnvironmentStrings("%USERNAME%")
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.CreateTextFile("store\" & LCase(UserName) & ".csv", ForWriting, True)

Set objOpenFile = objFSO.OpenTextFile("store\" & UserName & ".csv")
objFile.WriteLine(UserName & "," & Now & "," & Version)
objFile.Close


'------------------------------Open directory.txt and update----------------------------------
If .FileExists("store\directory.txt") Then
    Set objFile = objFSO.OpenTextFile("store\directory.txt", 8, True)
Else
    Set TxtFile = objFSO.CreateTextFile("store\directory.txt")
End If

objFile.WriteLine(UserName)
objFile.Close




        
        
