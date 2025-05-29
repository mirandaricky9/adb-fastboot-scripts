#!/bin/bash
# Created by: Ricky Miranda
# Date: May 2025
# A script that will read a list of devices provided by 'adb devices' and loop through them,
# collecting the serial numbers and executing a separate script (checkSingleDevice.sh) to extract information from each serial number,
# saving it in a .txt format.
# Afterwards, all logs will be uploaded to a google drive folder based on a ticket number. If no 
# folder exists with the corresponding ticket number, a new folder will be created.

# Requirements: Google Drive must be connected to your directory and properly routed.

# Warnings: Please be sure not to run this script in a folder that contains other .txt files.


# @parameters:
# $device - serial number of device
# 


shopt -s extglob ## enabling extended globbing for this script

echo "# Collecting logs for devices below"



adb devices | while read line
do
    if [ ! "$line" = "" ] && [ `echo $line | awk '{print $2}'` = "device" ]
    then
         device=`echo $line | awk '{print $1}'`
	     echo "*** Checking $device ***"
	     echo ""

             # Check $device (serial) 
             echo "cd "$(pwd)/"; ./checkSingleDevice.sh $device" > ./tmp.sh ; chmod +x ./tmp.sh ; ./tmp.sh &
    fi
    sleep 1
done

sleep 1
rm tmp.sh



# Uploading logs to the Google Drive
printf "\nUploading logs to the drive...\n"

# extract ticket number from ticketNumber.txt file 
# if the ticket number exists in the folder, paste logs there,
# otherwise, create folder and paste logs there
#file="ticketNumber.txt"

ticket2="$(ls t-*)/"


#echo "The name of the folder is $ticket2"

#while read -r line; do
#  ticket=$line
#done <$file
#echo $ticket

success=0

count="$(ls *.txt | wc -l | tr -d " ")"
directory="" # *** Insert path to directory here


# quoting the variable so that the asterisk can be read as a wildcard
for d in "$directory"*/; do
   if [ "$d" == "$directory$ticket2" ]; then
      echo "A directory match has been found."
      cp *.txt "$d"
      mv *.txt archiveLogs/
      success=$((success+1))
      echo "The $count logs were successfully uploaded to an existing directory, $ticket2"
      echo "The $count logs can also be found in archiveLogs/ directory."
      break
   fi

done

#echo "$success"
if [ $success == 0 ]; then
   echo "No directory was found, Creating a new one... "
   mkdir "$directory$ticket2"
   cp *.txt "$directory$ticket2"
   mv *.txt archiveLogs/
   echo "The $count logs were successfully uploaded to a NEW directory, $ticket2"
   echo "The $count logs can also be found in archiveLogs/ directory."
fi