#!/usr/bin/env bash

# Determine absolute path of script in order to relative path to other files
script_path=$(realpath $0)
dir_path=$(dirname $script_path)

tmux_conf_template="$dir_path/tmux.conf.template"
tmux_conf_path="$HOME/.tmux.conf"
tmux_backup_path="$HOME/.tmux.conf.backup"

tpm_install_path="$HOME/.tmux/plugins/tpm"

##
# Checks if this script is being run as root, and exists if so.  This should
# be run as a normal user to prevent the tmux config from being root owned.
##
function check_root() {
    if [ "$EUID" -eq 0 ]; then
        echo "This should not be run as root.  Exiting."
        exit
    fi
}

##
# Checks if the tmux plugin manager is installed, and installs it if not
##
function install_tpm() {
    if [ ! -d $tpm_install_path ]; then
        echo "tpm not detected, installing."
        git clone https://github.com/tmux-plugins/tpm $tpm_install_path
    else
        echo "tpm installation detected, skipping install."
    fi
}

##
# Sets the users tmux configuration.  If a config already exists, we make
# a backup of it before setting the config.
##
function set_tmux_config() {
    if [ -f $tmux_conf_path ]; then
        echo "Existing tmux config detected, backing up to: $tmux_backup_path"
        mv $tmux_conf_path $tmux_backup_path
    fi 

    cp $tmux_conf_template $tmux_conf_path
}

##
# Initializes tpm plugins as defined in the tmux config.
##
function initialize_tpm_plugins() {
    echo "Installing tpm plugins"
   
    pidof tmux 
    tmux_running=$?

    if [ $tmux_running -ne 1 ]; then
        echo "Detected tmux process running, sourcing tmux with new config."
        tmux source $tmux_conf_path
    fi

    /usr/bin/env bash "$tpm_install_path/bin/install_plugins"
}

##
# Main
##
function main() {
    echo
    check_root
    install_tpm
    set_tmux_config
    initialize_tpm_plugins
    echo
    echo "tmux setup complete"
    echo
}

main "$@"
