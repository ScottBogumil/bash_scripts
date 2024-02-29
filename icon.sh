#!/bin/bash

###############################################################################
# this script takes user input, creates a file formatted for a desktop icon   #
# and moves the file to the applicaitons folder to populate the icon          #
###############################################################################


# prompts user for input
read -p "Enter filename with .desktop extension: " fileName
read -p "Enter icon name: " iconName
read -p "Enter version: " version
read -p "Enter icon absolute path: " iconPath
read -p "Enter executable file absolute path: " execFileLoc

# creates file locally
touch $fileName
# writes user input to file
cat <<EOM> $fileName
[Desktop Entry]
Version=$version
Type=Application
Terminal=false
Icon[en_US]=$iconPath
Name[en_US]=$iconName
Exec=$execFileLoc
Name=$iconName
Icon=$iconPath
EOM

# allows executable permissions
sudo chmod 664 $fileName

# changes ownership to root
sudo chown root:root $fileName

# moves file to correct folder
sudo mv $fileName /usr/share/applications/$fileName

echo "Icon created!"
