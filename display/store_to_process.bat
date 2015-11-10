@ECHO OFF
ECHO Beginning Transfer...

if not exist "process" mkdir process

XCOPY "store\*.csv" "process\" /Y /Q

ECHO Transfer Complete!
PAUSE