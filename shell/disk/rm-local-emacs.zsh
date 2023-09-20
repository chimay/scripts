#! /usr/bin/env zsh

(( $# == 0 )) && {

	echo Usage : ${0##*/} version
	echo

	exit
}

version=$1

# {{{ Dossiers

dossiers=()

dossiers+=(/usr/local/libexec/emacs)
dossiers+=(/usr/local/share/emacs)

# }}}

echo "sudo rm -f /usr/local/bin/emacs-$version"
echo

sudo rm -f /usr/local/bin/emacs-$version

for reper in $dossiers
do
	echo "sudo rm -rf $reper/$version"
	echo

	sudo rm -rf $reper/$version
done
