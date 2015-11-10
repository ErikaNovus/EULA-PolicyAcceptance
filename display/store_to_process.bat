@ECHO OFF
ECHO Beginning Transfer...

if not exist "process" mkdir process

robocopy "store" "process" *.csv /MOV

ECHO Transfer Complete!
PAUSE