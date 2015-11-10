# EULA-AcceptanceLogging
Script for logging user acceptance of a company EULA.
This is created to be run from Active Directory on networked users PC's.

For this script to work fully there must be two text files created:
  + directory.txt - This file will hold the usernames ONLY of all the users who have accepted the EULA. This file is used to        search for users who have previously accepted the EULA.
  + users.txt - This file will hold the Usersnames, Date and time, and EULA version number (defined in EULA.vbs) and does not get   searched. This file is for logging purposes only.

The scripts run in the order of: logon.vbs > EULA.hta > EULA.vbs

The plan is for users.txt to be a continuous log of user acceptance across every version of the EULA and as such will never be deleted. directory.txt on the other hand, since it keeps a record of acceptance of the current version, should be deleted every time the EULA itself is updated so that even users who have accepted previously will see the new update version of the EULA.

## logon.vbs
The first script to run. This script searches a file "directory.txt" for the username of the currently logged on Active directory user. If the current username is found then the script quits and normal log on procedure continues.
If the username is not found logon.vbs firstly calls DisableTaskMgr to stop the user from calling the task manager and then opens EULA.hta.

## EULA.hta
A basic webpage file that will hold the current version of the EULA which can be updated easily by changing the html code at the bottom of the script.
There is a short piece of Javascript code that is used to stop the user from closing EULA.hta using escape keys. 
There are two buttons on the form "I Accept" and "I Decline" when the former is pressed EULA.vbs is opened. If "I Decline" is pressed the user is logged off the PC and no log is taken.

## EULA.vbs
A short script that re-enables the task manager for the user. The script then updates directory.txt with the username of the currently logged on user and then creates a single-line .csv file containing the username, time and date, and current version number of the EULA.

### Escape block
A small note for running tests on this script and making changes. There are some code blocks that stop the task manager from being opened whilst EULA.hta is open. This is to stop users from bypassing the acceptance. If you run the script you will have to accept the policy otherwise you will not be able to get back to the desktop. If any changes are made to file paths please make sure that the "I accept" button is relinked to EULA.vbs otherwise the button will not work and you will be stuck inside EULA.hta. The "I decline" button will log you out no matter what though so that is an easy way out.

Keys blocked by EULA.hta:
+ _116 = alt+f5_
+ _115= alt+f4_
+ _27 = alt+esc_
+ _76 = win+l_
+ _ctrl+alt+del_

### store_to_process.bat
Very short batch file that uses Robocopy to move all current .csv files into the process folder so that they can be picked up by an SSIS package (see [here](https://www.mssqltips.com/sqlservertip/2874/loop-through-flat-files-in-sql-server-integration-services/)) and transferred into an SQL database for easy concurrent read/write access.
Two folders are needed due to the original folder being constantly written to and copying into the SQL database whilst the folder is being written too was a issue I didn't want to try to figure out and so used an easier issue.



**logon.vbs turns off the task manager. It is only reactivated when EULA.vbs is run.**
