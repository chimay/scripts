#! /usr/bin/env zsh

(( $# == 0 )) && {

	echo Usage : ${0##*/} version
	echo

	exit
}

version=$1

# {{{ Dossiers

dossiers=()

dossiers+=(/usr/local/lib/zsh)
dossiers+=(/usr/local/share/zsh)

# }}}

echo "sudo rm -f /usr/local/bin/zsh-$version"
echo

sudo rm -f /usr/local/bin/zsh-$version

for reper in $dossiers
do
	echo "sudo rm -rf $reper/$version"
	echo

	sudo rm -rf $reper/$version
done
