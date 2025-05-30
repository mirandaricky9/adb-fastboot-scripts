#/bin/bash
# Created by: Ricardo Miranda
# Date: May 2025
# Disclaimer: This is based on a MacOS file system.

# Formatting
TRED=$(tput setaf 1)
TGREEN=$(tput setaf 2)
TYELLOW=$(tput setaf 3)
TBLUE=$(tput setaf 4)
TMAGENTA=$(tput setaf 5)
TCYAN=$(tput setaf 6)
TBROWN=$(tput setaf 9)
TGREY=$(tput setaf 8)
TBOLD=$(tput bold)
TUNDERLINE=$(tput smul)
TBLINK=$(tput blink)
TRESET=$(tput sgr0)

WORKING_DIRECTORY=/Users/$(whoami)/Flashing/

# PREQUISITES:
# there can only be one set of the neccesary files in the downloads folders,
# at any point in time. 



# Creating a script that will create a new folder using the latest zip
# file that has been downloaded from the android build (go/ab) website,

# Three Files will be looked for:
# bootloader.img
# radio.img
# build.zip 

# Navigate to the Downloads folder where the zip build is downloaded
cd ~/Downloads/

 
fullNameZip=$(echo *-img-*.zip) # e.g. felix-img-11583385.zip
fullName=$(echo *-img-*.zip | cut -d '.' -f 1) # e.g. felix-img-11583385
projName=$(echo *-img-*.zip | cut -d '-' -f 1) # e.g. felix

echo "${TGREEN}Extracting build information.${TRESET}"
echo $fullNameZip
echo $fullName
echo $projName

if [ "$projName" == "signed" ]
then
    signed=$(echo *-img-* | cut -d '-' -f 1) # e.g. signed
    projName=$(echo *-img-* | cut -d '-' -f 2) # e.g. felix
    versionNum=$(echo *-img-* | cut -d '-' -f 4) # e.g. 11583385.zip
    versionBuild=$(echo $versionNum | cut -d '.' -f 1) # e.g. 11583385
else
    versionNum=$(echo *-img-* | cut -d '-' -f 3) # e.g. 11583385.zip
    versionBuild=$(echo $versionNum | cut -d '.' -f 1) # e.g. 11583385
fi

echo $versionBuild

mv radio.img bootloader.img $fullNameZip $WORKING_DIRECTORY


# # # Navigate to the flashing directory
cd $WORKING_DIRECTORY

# ls $versionBuild
# countDir=$(ls $versionBuild | wc -l)


# Creating a helper function that moves files into directory
move_files_to_flashing_directory () {
    mv radio.img bootloader.img $fullNameZip $versionBuild
    cd $versionBuild
    cp -r $WORKING_DIRECTORY/flashing_template/RenameProjectBuild $projName
    mv radio.img bootloader.img $fullNameZip $projName
    cd $projName
    mkdir $fullName
    mv $fullNameZip $fullName
    cd $fullName
    unzip $fullNameZip
    cd $WORKING_DIRECTORY
}


if [ -d $versionBuild ] # if the directory does exist
then
    move_files_to_flashing_directory

else # if the directory doesn't exist
    cp -r flashing_template $versionBuild
    move_files_to_flashing_directory

    fi