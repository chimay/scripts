#!/usr/bin/env /bin/zsh

# vim: set filetype=zsh:

# {{{ Options

emulate -R zsh

setopt local_options

setopt warn_create_global

setopt extended_glob

#setopt null_glob

#zmodload zsh/regex

# }}}

# {{{ Arguments

nombres=()

aide=0

autres=()

while true
do
	case $1 in
		-h)
			aide=1
			shift
			;;
		[0-9.]##)
			nombres+=$1
			shift
			;;
		?*)
			autres+=$1
			shift
			;;
		*)
			break
			;;
	esac
done

# }}}

# Aide {{{1

[ $#autres -lt 2 -o $aide -eq 1 ] && {
	echo "Usage: $(basename $0) [duration] file-in-1 ... file-in-N file-out"
	exit 0
}

# }}}1

# Variables {{{1

duree=${${nombres[1]}:-1.0}

entrees=($autres[1,-2])
sortie=($autres[-1])

temp=$$.$sortie

# }}}1

echo "cp $entrees[1] $temp"
echo

cp $entrees[1] $temp

for ind in {2..$#entrees}
do
	ajout=$entrees[$ind]

	echo "sox -V3 $temp $ajout $sortie splice -h $(soxi -D $temp),$duree"
	echo

	sox -V3 $temp $ajout $sortie splice -h $(soxi -D $temp),$duree

	echo
	echo "mv -f $sortie $temp"
	echo

	mv -f $sortie $temp
done

echo
echo "mv -f $temp $sortie"
echo

mv -f $temp $sortie
