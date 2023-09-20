#! /usr/bin/env zsh

(( $# == 0 )) && {

	echo Usage : ${0##*/} version
	echo

	exit
}

version=$1

# {{{ Dossiers

dossiers=()

dossiers+=(/usr/local/share/vim)

# }}}

for reper in $dossiers
do
	echo "sudo rm -rf $reper/vim$version"
	echo

	sudo rm -rf $reper/vim$version
done
