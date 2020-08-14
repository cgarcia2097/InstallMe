#!/bin/bash
# Generates small templates for the installers to a directory

NAME="{NAME}"
DATE="{DATE}"
TEMPLATE="./installer_template.txt"
LIST=''
INSTALLER_DIR=''
LOWER=''
FILE=''

##################################################
# Functions
##################################################

# Display usage of the script
function usage(){
    echo "Usage: ./template_generator.sh [DIRECTORY] [LIST] [TEMPLATE]"
}

##################################################
# Main script
##################################################

# Use specified list in template generator
if [ -z "$2" ]; then                  # Check if list arg is null
    echo "Failed to specify list"
    usage
    exit 1    
elif [ ! -f "$2" ]; then                # Check if file exists
    echo "List file does not exist"
    usage
    exit 1 
else                                    # Use the chosen file
    echo "List file detected. Using list file $2"
    LIST=$2
fi

# Check for template file
if [ -z "$3" ]; then                    # Check if template arg is null
    echo "Failed to specify template file"
    usage
    exit 1
elif [ ! -f "$3" ]; then                  # Check if template file exists
    echo "Template file does not exist"
    usage 
    exit 1
else
    echo "Template file detected. Using list file $3"
    TEMPLATE=$3
fi

# Create directory for the installer files
if [ -z "$1" ]; then                     # Check if directory arg is null
    echo "Failed to specify directory"
    usage
    exit 1
elif [ -d "$1" ]; then                  # Check if the directory exists
    INSTALLER_DIR=$1
else                                    # Create new directory
    INSTALLER_DIR=$1
    mkdir $INSTALLER_DIR
fi

# Generate the templates from list
while read var
do
    LOWER=$(echo $var | tr '[:upper:]' '[:lower:]')     
    touch "${LOWER}_installer.sh"                    # Create file
    FILE="${LOWER}_installer.sh"
    cat $TEMPLATE >> $FILE                           # Copy template over to new file
    sed -i "s/$NAME/${var}/" $FILE                   
    sed -i "s/$DATE/$(date)/" $FILE                  
done < $LIST

# Move installer templates there
for files in ./*_installer.sh
do
    chmod +x $files
    mv $files $INSTALLER_DIR
done

# End of template generation
echo "Finished template generation on $(date)"
exit 0