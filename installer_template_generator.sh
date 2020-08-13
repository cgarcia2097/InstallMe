#!/bin/bash
# Generates small templates for the installers to specified directory

NAME="{NAME}"
TEMPLATE="./installer_template.txt"
LIST="./installer_list.txt"
INSTALLER_DIR=''
LOWER=''
FILE=''

# Generate the templates from list
while read var
do
    LOWER=$(echo $var | tr '[:upper:]' '[:lower:]')     
    touch "${LOWER}_installer.sh"                    # Create file
    FILE="${LOWER}_installer.sh"
    cat $TEMPLATE >> $FILE                           # Copy template over to new file
    sed -i "s/$NAME/${var}/" $FILE                   # Replace the template words with argument
done < $LIST

# Create directory for the installer files
if [ -z "$1"]; then
    INSTALLER_DIR='installers'
else
    INSTALLER_DIR=$1
fi
mkdir $INSTALLER_DIR

# Move installer templates there
for files in ./*_installer.sh
do
    chmod +x $files
    mv $files $INSTALLER_DIR
done