# EULA-AcceptanceLogging
Script for logging user acceptance of a company EULA.
This is created to be run from Active Directory on networked users PC's.

For this script to work fully there must be two text files created:
  directory.txt - This file will hold the usernames ONLY of all the users who have accepted the EULA. This file is used to        search for users who have previously accepted the EULA.
  users.txt - This file will hold the Usersnames, Date and time, and EULA version number (defined in EULA.vbs) and does not get   searched. This file is for logging purposes only.

The scripts run in the order of: logon.vbs > EULA.hta > EULA.vbs

The plan is for users.txt to be a continuous log of user acceptance across every version of the EULA and as such will never be deleted. directory.txt on the other hand, since it keeps a record of acceptance of the current version, should be deleted every time the EULA itself is updated so that even users who have accepted previously will see the new update version of the EULA.

# logon.vbs
The first script to run. This script searches a file "directory.txt" for the username of the currently logged on Active directory user. If the current username is found then the script quits and normal log on procedure continues.
If the username is not found logon.vbs firstly calls DisableTaskMgr to stop the user from calling the task manager and then opens EULA.hta.

# EULA.hta
A basic webpage file that will hold the current version of the EULA which can be updated easily by changing the html code at the bottom of the script.
There is a short piece of Javascript code that is used to stop the user from closing EULA.hta using escape keys. 
There are two buttons on the form "I Accept" and "I Decline" when the former is pressed EULA.vbs is opened. If "I Decline" is pressed the user is logged off the PC and no log is taken.

# EULA.vbs
A short script that re-enables the task manager for the user. The script then updates directory.txt with the username of the currently logged on user and then updates users.txt with the username, time and date, and current version number of the EULA.


