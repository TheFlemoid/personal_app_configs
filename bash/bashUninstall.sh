#!/usr/bin/env bash

FILE=~/.bashrc

if [ -f "$FILE" ]; then
	echo ".bashrc config file found."
	echo "Redacting changes from DeliciousLunch55 configs"
	cp ~/.bashrc .bashTemp
	sed -i '/# BEGIN DELICIOUSLUNCH55 APPENDED BASHRC/,/# END DELICIOUSLUNCH55 APPENDED BASHRC/d' .bashTemp
	mv .bashTemp ~/.bashrc
fi
