#!/usr/bin/env bash

cat .bashrc ~/.bashrc > interimBash.sh
chmod 774 interimBash.sh
rm -rf ~/.bashrc
mv interimBash.sh ~/.bashrc
