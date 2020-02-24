#!/usr/bin/env bash

FILE=~/.bashrc

if [ -f "$FILE" ]; then
	echo "Existing .bashrc config found."
	echo "Appending additions to existing .bashrc config."
	cat .bashrc ~/.bashrc > interimBash.sh
	rm -f $FILE
else
	echo "No existing .bashrc config found."
	echo "Creating .bashrc config from additions."
	cat .bashrc > interimBash.sh
fi
	chmod 774 interimBash.sh
	mv interimBash.sh ~/.bashrc
