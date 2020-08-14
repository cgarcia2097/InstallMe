# Discount Ninite 

These set of scripts allow the user to generate a set of installer templates for a typical Linux system, as well as automate a set of scripts once all the install scripts have been implemented. Useful for fresh installs of a Linux system once implemented properly

The *template generator* and the *install script* can be run as seperate programs as the user desires.

## Workflow
1. Populate `installer_list.txt` with possible candidate programs
2. Run `installer_template_genrator.sh` to generate the templates
3. Populate each install template with the appropriate commands to implement the install script
4. Execute all the install scripts with `install_scripts.sh`

## Usage

Installer template generator
- `./template_generator.sh [DIRECTORY] [LIST] [TEMPLATE]`

Automated installer script
- `./install_scripts.sh [DIRECTORY]`

## Examples

- **List**: `example_list.txt` shows an example format creating a list for template generation. Here's a snippet:

```
KiCAD
VSCode
Discord
Wireshark
Chrome
FreeCAD
...
```

- **Template**: `example_template.txt` shows an example template used for template generation. The script uses the `{DATE}` and `{NAME}` tags in the template generation

``` 
#!/bin/bash
# Generated at {DATE}
# {NAME} installer using the instructions here: {LINK}

# Prompt user about installation start
echo "Installing {NAME}..."
...
```
The resulting installer scripts will look like this (for example, with the KiCAD installer `kicad_installer.sh`)

```
#!/bin/bash
# Generated at Thu 13 Aug 2020 06:16:49 PM EDT
# KiCAD installer using the instructions here: {LINK}

# Prompt user about installation start
echo "Installing KiCAD..."
...
```

- **Commands**
  - *Template generator*: 

    ``./template_generator.sh ./installers ./example_list.txt ./example_template.txt``
  - *Automated installer script*:

    `./install_scripts.sh ./installers/`

## Credits
- Charles Garcia (@cgarcia2097)