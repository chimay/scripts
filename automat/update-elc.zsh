#! /usr/bin/env zsh

setopt null_glob

date +" [=] %A %d %B %Y  (o) %H:%M  | %:z | "

for dossier in *
do
	echo ""
	echo "------------------------------------"
	echo ""

	echo "cd $dossier"
	echo
	echo "emacs --batch --eval '(byte-recompile-directory \".\")'"

	cd $dossier

    emacs --batch --eval '(byte-recompile-directory ".")'

	cd -
done
