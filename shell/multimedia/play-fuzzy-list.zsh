#!/usr/bin/env zsh

# vim: set filetype=zsh:

unsetopt case_glob

numarg=$#

# {{{ Arguments

aide=0

stdin=0

fanions=()

while true
do
	case $1 in
		-h)
			aide=1
			shift
			;;
		-)
			stdin=1
			shift
			;;
		-?*)
			fanions+=$1
			shift
			;;
		?*)
			fichier=$1
			shift
			;;
		*)
			break
			;;
	esac
done

[ -z $fichier ] && stdin=1

# }}}

# Affichage {{{1

echo Fichier : $fichier
echo Stdin : $stdin
echo Fanions : $fanions
echo

# }}}1

# Aide {{{1

[ $numarg -eq 0 -o $aide -eq 1 ] && {
	echo "Usage: $(basename $0) list-file mpv-flags"
	echo "\tif list-file = - or none : reads stdin"
	echo
	exit 0
}

# }}}1

liste=()

if [ $stdin -gt 0 ]
then
	echo Reading stdin
	echo
	while read motif
	do
		liste+=(**/*$motif*(.))
	done
else
	echo Reading $fichier
	echo
	cat $fichier | while read motif
	do
		liste+=(**/*$motif*(.))
	done
fi

echo Playlist
echo "------------------------------"
echo
print -l $liste
echo
echo Playing
echo "------------------------------"
echo
echo "mpv $=fanions <liste>"
echo
mpv $=fanions $=liste
