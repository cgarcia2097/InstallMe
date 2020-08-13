#!/bin/bash
# Used for fresh installs of a Linux system.

INSTALLER_DIR=''

# Check if user is root
SUDO=''
if (($EUID != 0)); then
    SUDO='sudo'
fi

# Specify installer directory
if [ -z "$1" ]
    then
    echo "Please specify a directory"
    echo "Usage: ./install_scripts.sh [INSTALLER_DIRECTORY]"
    exit 1
else
    INSTALLER_DIR=$1
fi

# Check if directory exists
if [ ! -d "$INSTALLER_DIR" ]
    then
    echo "Installer directory doesn't exist."
    echo "Usage: ./install_scripts [INSTALLER_DIRECTORY]"
    exit 1
fi

# Iterate through each install script 
for file in $INSTALLER_DIR/*_installer.sh
do
    $SUDO ./$file
done

# End of installation
echo "Finished installation on $(date). Enjoy!!!"
exit 0
