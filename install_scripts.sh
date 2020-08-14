#!/bin/bash
# Used for fresh installs of a Linux system.

INSTALLER_DIR=''
INSTALLER_LOG=''
MESSAGE=''
SUDO=''

########################################
# Functions
########################################

# Function for writing to log file
# Set $MESSAGE variable first before writing message
function record2Log(){
    echo $MESSAGE
    echo "{$(date)} - $MESSAGE" >> $INSTALLER_LOG
}

# Function for when script is interrupted
function ctrlc(){

    # Prompt user of interrupt
    MESSAGE="Install script interrupted... Cleaning up (2)"

    # Record interrupt in log
    record2Log 

    # Exit shell with error code 2
    exit 2
}

########################################
# Main script
########################################

# Set up SIGINT function
trap "ctrlc" 2

# Check if user is root
if (($EUID != 0)); then
    SUDO='sudo'
fi

# Use specified directory
if [ -z "$1" ]              # Check if directory arg is null
    then                    
    echo "Failed to specify a directory"
    echo "Usage: ./install_scripts.sh [INSTALLER_DIRECTORY]"
    exit 1
elif [ ! -d "$1" ]          # Check id directory exists
    then
    echo "Installer directory doesn't exist."
    echo "Usage: ./install_scripts [INSTALLER_DIRECTORY]"
    exit 1
else
    INSTALLER_DIR=$1
fi

# Create log file 
INSTALLER_LOG="$INSTALLER_DIR/install_log.txt" 
rm -rf $INSTALLER_LOG                           # Remove previous log file
touch $INSTALLER_LOG

MESSAGE="Install started"
record2Log

# Iterate through each install script
for file in $INSTALLER_DIR/*_installer.sh
do
    MESSAGE=''
    $SUDO ./$file
    if [ $? -ne 0 ]; then
        MESSAGE="Install failed for $file (Error $?)"
        record2Log
        exit 1
    else
        MESSAGE="Install success for $file"
    fi
    record2Log
done

# End of installation
MESSAGE="Finished installation. Enjoy!!!"
record2Log
exit 0
