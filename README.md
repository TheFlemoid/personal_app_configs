Personal configurations for various applications.

--------------------
BASH CONFIGURATION:
--------------------
 1. To install bashrc scripts run the bashSetup.sh script in the bash folder.  Do not run the setup as sudo, as this will change the user/group ownership of your .bashrc file to root:root.  This will append your current ~/.bashrc file with the bash configuration.
 2. To uninstall bashrc scripts run the bashUninstall.sh script in the bash folder.  Do not run the uninstaller as sudo.

--------------------
VIMRC CONFIGURATION:
--------------------
 1. To install vimrc scripts run the vimrcSetup.sh script in the vimrc folder.  Do not run the setup as sudo, as this will apply root:root ownership to the .vimrc file.  This will copy the .vimrc file in the vim folder to your home directory.  If an existing .vimrc file is present, this will be renamed to .vimrc_old for future copying or for uninstallation of this .vimrc config.
 2. To uninstall vimrc scripts run the vimrcUninstall.sh script in the vimrc folder.  This will check to see if a  .vimrc_old file exists in the user's /home.  If one does, it will rename it to .vimrc, replacing the current .vimrc.  If not, the uninstaller will do nothing.  If you wish to uninstall and you have no .vimrc_old configuration, just delete the .vimrc from /home. 
