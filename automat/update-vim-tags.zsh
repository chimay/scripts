#! /usr/bin/env zsh

setopt null_glob

date +" [=] %A %d %B %Y  (o) %H:%M  | %:z | "

directory=${1:-.}

cd $directory

# Git {{{1

for folder in *(/)
do
	echo ""
	echo "------------------------------------"
	echo ""

	echo "cd $folder"
	echo
	cd $folder

	[ -d doc ] || {
		cd -
		continue
	}

	echo "vim -u NONE +'helptags doc' +q"
	echo
	vim +'helptags doc' +q

	cd -
done

# Fin {{{1

	echo ""
	echo "===================================="
	echo ""
