#!/usr/bin/env bash

BASHRC=~/.bashrc

echo ""
if [ "$EUID" -eq 0 ]; then
	echo "This should not be run as root.  Exiting."
	exit
fi

if [ -f "$BASHRC" ]; then
	echo ".bashrc config file found."
	echo "Redacting changes from DeliciousLunch55 configs"
	cp ~/.bashrc .bashTemp
	sed -i '/# BEGIN DELICIOUSLUNCH55 APPENDED BASHRC/,/# END DELICIOUSLUNCH55 APPENDED BASHRC/d' .bashTemp
	mv .bashTemp ~/.bashrc
else
	echo "No .bashrc config file found!"
	echo "Nothing to do!"
fi
