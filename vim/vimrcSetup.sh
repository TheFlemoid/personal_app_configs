#!/usr/bin/env bash

FILE=~/.vimrc

if [ -f "$FILE" ]; then
	echo "Existing .vimrc config found."
	echo "Renaming current .vimrc to .vimrc_old to retain for uninstall if necessary."
	mv $FILE ~/.vimrc_old
else
	echo "No current .vimrc config found."
fi
	echo "Setting DeliciousLunch55 Vim config file as .vimrc."
	cp .vimrc ~
	chmod 775 $FILE
