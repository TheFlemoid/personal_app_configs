#!/usr/bin/env bash

if [ "$EUID" -eq 0 ]; then
	echo "This should not be run as root.  Exiting."
	exit
fi

cp ./vimrc2 ~/.vimrc
chmod 775 ~/.vimrc
