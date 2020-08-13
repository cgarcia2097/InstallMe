#!/bin/bash
#
# Used for fresh installs of my Linux system.

INSTALLER_DIR="./installers"

# Check if user is root
SUDO=''
if (($EUID != 0)); then
    SUDO='sudo'
fi

# Iterate through each install script stored in 
for file in $INSTALLER_DIR/*_installer.sh
do
    $SUDO ./$file
done

# End of installation
echo "Finished installation on $(date). Enjoy!!!"
sleep 3
exit
