#!/usr/bin/env bash

FILE=~/.vimrc_old
PLUG=~/.vim/autoload/plug.vim
PLUGDIR=~/.vim/plugged

echo ""
if [ "$EUID" -eq 0 ]; then
	echo "This should not be run as root.  Exiting."
	exit
fi

if [ -f "$FILE" ]; then
	echo ".vimrc_old file found. Restoring."
	mv $FILE ~/.vimrc
else
	echo "No .vimrc_old file found!  Nothing to do!"
fi

if [ -f "$PLUG" ]; then
	echo "vim-Plug found. Deleting."
	rm -f $PLUG
fi

if [ -d "$PLUGDIR" ]; then
	echo "vim-Plug plugins found.  Deleting."
	rm -rf $PLUGDIR
fi

echo ""
echo "-----------------------------"
echo "vimrc Uninstallation Complete"
echo "-----------------------------"
echo ""
