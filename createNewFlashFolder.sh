#!/bin/bash

# Created by: Ricardo Miranda
# Date: May 2025
# Disclaimer: This is based on a MacOS file system.

# PREQUISITES:
# There can only be one copy of the neccesary files in the downloads folders,
# at any point in time. 

# Creating a script that will create a new folder using the latest zip
# file that has been downloaded from the android website,

# Three Files will be looked for:
# bootloader.img
# radio.img
# build.zip 



# Navigate to the Downloads folder where the zip build is downloaded
cd ~/Downloads/


fullNameZip=$(echo *-img-*) # e.g. felix-img-11583385.zip
fullName=$(echo *-img-* | cut -d '.' -f 1) # e.g. felix-img-11583385
projName=$(echo *-img-* | cut -d '-' -f 1) # e.g. felix


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


mv radio.img bootloader.img $fullNameZip ~/Flashing/


# # Navigate to the flashing directory
cd ~/Flashing/

if [ -z "$signed" ] # if signed is null
then
cp -r flashing_template $projName$versionBuild
mv radio.img bootloader.img $fullNameZip $projName$versionBuild
cd $projName$versionBuild
# echo "variable is null"

else # if $signed is not null
cp -r flashing_template $signed$projName$versionBuild
mv radio.img bootloader.img $fullNameZip $signed$projName$versionBuild
cd $signed$projName$versionBuild
# echo $signed
fi


mv RenameProjectBuild $projName

mv radio.img bootloader.img $fullNameZip $projName

cd $projName

mkdir $fullName

mv $fullNameZip $fullName

cd $fullName

unzip $fullNameZip

cd ~/Flashing/

# Copying to Google Drive Zipped Builds

echo "Do you wish to upload the folder to Google Drive?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
        if [ -z "$signed" ] # if signed is null
        then
        zip -r "${projName}${versionBuild}.zip" $projName$versionBuild
        cp -r "${projName}${versionBuild}.zip" "/Users/mirandaricardo/Google Drive/My Drive/shortcuts/carrier-shared/carrier-shared/Zipped builds"
        else # if $signed is not null
        zip -r "${signed}${projName}${versionBuild}.zip" $signed$projName$versionBuild
        cp -r "${signed}${projName}${versionBuild}.zip" "/Users/mirandaricardo/Google Drive/My Drive/shortcuts/carrier-shared/carrier-shared/Zipped builds"
        fi
        echo "File upload has begun. Check Google Drive extension for progress."
        exit
        ;;
        No ) 
        
        exit;;
        esac
done