#!/usr/bin/env bash

BASHRC=~/.bashrc

echo ""
if [ "$EUID" -eq 0 ]; then
	echo "This should not be run as root.  Exiting."
	exit
fi

if [ -f "$BASHRC" ]; then
	echo "Existing .bashrc config found."
	echo "Appending additions to existing .bashrc config."
	cat .bashrc ~/.bashrc > interimBash.sh
	rm -f $BASHRC
else
	echo "No existing .bashrc config found."
	echo "Creating .bashrc config from additions."
	cat .bashrc > interimBash.sh
fi
	chmod 774 interimBash.sh
	mv interimBash.sh ~/.bashrc
