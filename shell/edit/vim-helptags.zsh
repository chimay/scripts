#!/usr/bin/env zsh

start=${1:-.}

cd $start

for folder in *(/)
do
	echo "cd $folder"
	echo
	cd $folder
	echo "neovim-lite.sh +'helptags doc' +q"
	echo
	neovim-lite.sh +'helptags doc' +q
	echo "cd -"
	echo
	cd -
done
