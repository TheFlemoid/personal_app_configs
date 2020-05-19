#!/usr/bin/env bash

FILE=~/.vimrc
OLD_VIMRC=~/.vimrc_old
PLUG=~/.vim/autoload/plug.vim

if [ "$EUID" -eq 0 ]; then
	echo "This should not be run as root.  Exiting."
	exit
fi

if [ -f "$FILE" ]; then
	if [ -f "$OLD_VIMRC" ]; then
		echo "Existing backup vimrc found, not overwriting backup vimrc."
	else
		echo "Existing .vimrc config found."
		echo "Renaming current .vimrc to .vimrc_old to retain for uninstall if necessary."
		mv $FILE ~/.vimrc_old
	fi
else
	echo "No current .vimrc config found."
fi

	echo "Setting DeliciousLunch55 Vim config file as .vimrc."
	cp vimrc1 ~
	mv ~/vimrc1 ~/.vimrc
	chmod 775 $FILE

	if [ -f "$PLUG" ]; then
		echo "Plug appears to already be installed.  Skipping plug installation."
	else
		echo "Installing plug"
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi

vim -c ':PlugInstall'
vim -c ':qa!'
