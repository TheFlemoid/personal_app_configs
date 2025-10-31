#!/usr/bin/bash

# File:  install_packages.sh
# Author:  Franklyn Dahlberg
# Created: 30 October, 2025
# Copyright: 2025 (c) Franklyn Dahlberg

# This script installs a standard set of packages that I typically
# use on all of my machines.

APT_MACHINE=-1;
DNF_MACHINE=-1;

APT_PACKAGES_FILENAME="apt_packages.txt"
DNF_PACKAGES_FILENAME="dnf_packages.txt"

SCRIPT_DIR=$(dirname "$0")
PACKAGE_ARRAY=""
INSTALL_CMD="";

#
# Exits this script if it is not being run as the root user.
#
function check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo "This script must be run as root. Exiting."
        exit -1
    fi
}

#
# Determines what package manager is in use on this machine.
#
function check_package_manager() {
    which apt > /dev/null
    APT_MACHINE=$?

    which dnf > /dev/null
    DNF_MACHINE=$?
}

#
# Generates the installation command based on the package manager
#
function generate_install_command() {
    if [ $APT_MACHINE -eq 0 ]; then
        echo "This is an apt based machine."
        apt_packages=${SCRIPT_DIR}/${APT_PACKAGES_FILENAME}
        readarray -t PACKAGE_ARRAY < $apt_packages
        echo "Packages to install: ${PACKAGE_ARRAY[*]}"
        INSTALL_CMD="apt install ${PACKAGE_ARRAY[*]}"
    fi

    if [ $DNF_MACHINE -eq 0 ]; then
        echo "This is a dnf based machine."
        dnf_packages=${SCRIPT_DIR}/${APT_PACKAGES_FILENAME}
        readarray -t PACKAGE_ARRAY < $dnf_packages
        echo "Packages to install: ${PACKAGE_ARRAY[*]}"
        INSTALL_CMD="dnf install ${PACKAGE_ARRAY[*]}"
    fi
}

#
# Run the install command to install packages
#
function install_packages() {
    echo "Will now run command:"
    echo "      $INSTALL_CMD"
    echo "Press 'y' to continue, or any other character to quit..."
    read -n1 USER_CONFIRM
    echo ""

    if [ "$USER_CONFIRM" = "y" ]; then
        echo "OK."
        $INSTALL_CMD
    else
        exit 0
    fi
}

#
# Script main
#
function main() {
    check_root
    check_package_manager
    generate_install_command
    install_packages
}

main "$@"

