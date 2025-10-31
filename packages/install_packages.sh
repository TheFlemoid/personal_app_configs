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
# Install packages using the 'apt' package manager
#
function install_packages_apt() {
    apt_packages=${SCRIPT_DIR}/${APT_PACKAGES_FILENAME}
    readarray -t PACKAGE_ARRAY < $apt_packages
    echo "Packages to install: ${PACKAGE_ARRAY[*]}"
    APT_INSTALL_CMD="apt install ${PACKAGE_ARRAY[*]}"
    echo "Will now run command:"
    echo "      $APT_INSTALL_CMD"
    echo "Enter 'y' to continue..."
}

#
# Script main
#
function main() {
    check_root

    # Test
    check_package_manager
    if [ $DNF_MACHINE -eq 0 ]; then
        echo "This is a dnf based machine."
    fi

    if [ $APT_MACHINE -eq 0 ]; then
        echo "This is an apt based machine."
        install_packages_apt
    fi
}

main "$@"

