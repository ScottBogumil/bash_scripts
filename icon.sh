#!/bin/bash
# creates an icon.desktop file with user input
read -p "Enter filename with .desktop extension: " fileName
read -p "Enter icon name: " iconName
read -p "Enter version: " version
read -p "Enter icon absolute path: " iconPath
read -p "Enter executable file absolute path: " execFileLoc

touch $fileName
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

sudo chmod 664 $fileName
sudo chown root:root $fileName

sudo mv $fileName /usr/share/applications/$fileName

echo "Icon created!"
