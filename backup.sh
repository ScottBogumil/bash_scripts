#!/bin/bash

###############################################################################
#
# ***************************RUN AS SUDO***************************************
#
# the purpose of this backup script is to backup a targeted directory, not
# an entire harddrive 
# my file system has been designed to be backed up using this script
# all files that I wish to backup are stored in DIR_TO_BACKUP
# I have set up a server with an ssh connection 
# this script sends the tar file to the server using rsync 
# then the script deletes the tar file locally
#
# for a light (smaller tar file) version simply exclude files 
# from tar using --exclude
#
# add following alias to .bashrc
# alias backup="cd /home/USER/DIRECTORY/LOCATION_OF_backup.sh && ./backup.sh"
#
##############################################################################
# USER = your user
# DIR_TO_BACKUP = your target backup directory
# DESTINATION = your chosen destination
# CONFIG_FILES = directory with backup config files coppied from home/user
##############################################################################


# copy files that you would like a backup of to your targeted directory
# these files cannot live in DIR_TO_BACKUP (easily)
# sudo to prevent access issues
sudo cp /home/USER/.bashrc /home/USER/DIR_TO_BACKUP/CONFIG_FILES/.bashrc.bkup           # bash config backup
sudo cp /home/USER/.bash_prompt /home/USER/DIR_TO_BACKUP/CONFIG_FILES/.bash_prompt.bkup # bash promt settings
sudo cp -r /home/USER/.ssh /home/USER/DIR_TO_BACKUP/CONFIG_FILES/.ssh.bkup              # ssh keys
sudo cp /etc/dnf/dnf.conf ~/DIR_TO_BACKUP/CONFIG_FILES/dnf.conf.bkup                    # system dnf.conf file

# create tar file using the date targeting your backup directory
tar -Jcvf /home/USER/backup.$(date '+%F').tar.xz /home/USER/DIR_TO_BACKUP
# use rsync to send the file to your chosen destination
rsync -avz /home/USER/backup.$(date '+%F').tar.xz USER@DESTINATION:/home/USER/MainBackup
# remove local tar file
rm /home/USER/backup.$(date '+%F').tar.xz

# optional power off after backup uncomment to use
# systemctl poweroff
