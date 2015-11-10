@ECHO OFF
ECHO Beginning Transfer...

XCOPY "store\*.csv" "process\" /Y /Q

ECHO Transfer Complete!
PAUSE