#! /bin/bash

#display and backup all files in the given directory and its sub-directory after certain modification date


trap 'echo "Signal recieved." ; rm $$* ; echo "Program interrupted." ; exit' HUP TERM


echo "-----------------------------------------------------------------"
echo -e "Enter the Date( MON DOM hr:min ),from we want to backup files : \c"
read date
echo -e "Enter the Directory path : \c"
read path
echo "-----------------------------------------------------------------"

find $path -type f -newermt "$date" 2> /dev/null 1> Backup.txt

D=`wc -c 0< Backup.txt`

if [ "$D" -ne 0 ]
then 
	echo "The Required files are : "
	echo "-----------------------------------------------------------------"
	cat Backup.txt
	echo "-----------------------------------------------------------------"
else
	echo "There are no such files in given directory."
	echo "-----------------------------------------------------------------"
	exit 0
fi


echo "-----------------------------------------------------------------"
echo -e "Are you want to backup these files ??? (y/n) : \c"
read choice
echo "-----------------------------------------------------------------"


case "$choice" in
	[yY]*)
		echo -e "Give the position where you want to backup : \c"
		read bcup
		mkdir "$bcup/BACKUP_DIRECTORY_`date`"
		BACKUP_LOCATION=$bcup/BACKUP_DIRECTORY_`date`
		for line in `cat Backup.txt`
		do
			cp -f "$line" "$BACKUP_LOCATION"
		done
		echo "Backup is complete."
		echo "-----------------------------------------------------------------"
		exit 0;;
	*)
		echo "No Backup is required."
		echo "-----------------------------------------------------------------"
		exit 0;;		
esac



