# Discount Ninite 

These set of scripts allow the user to generate a set of installer templates for a typical Linux system, as well as execute a set of scripts once all the install scripts have been implemented. Useful for fresh installs of a Linux system once implemented properly

The *template generator* and the *install script* can be run as seperate programs as the user desires.

## Workflow
1. Populate `installer_list.txt` with possible candidate programs
2. Run `installer_template_genrator.sh` to generate the templates
3. Populate each install template with the appropriate commands to implement the install script
4. Execute all the install scripts with `install_scripts.sh`

