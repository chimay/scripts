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

numarg=$#

aide=0

autres=()

while true
do
	case $1 in
		-h)
			aide=1
			shift
			;;
		[0-9]##)
			delai=$1
			shift
			;;
		[0-9.]##)
			minsec=$1
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

court=$autres[1]
long=$autres[2]
sortie=$autres[3]

# }}}

# Aide {{{1

[ $numarg -eq 0 -o $aide -eq 1 ] && {
	echo "Usage: $(basename $0) delai court long sortie"
	exit 0
}

# }}}1

# Temps {{{1

duree=$(soxi -D $long)

if [ -z $delai ]
then
	minutes=${minsec%.*}
	secondes=${minsec#*.}
	(( delai = 60 * minutes + secondes ))
else
	minutes=0
	secondes=$delai
fi

# }}}1

# Affichage {{{1

echo delai = $delai
echo minutes = $minutes
echo secondes = $secondes
echo court = $court
echo long = $long
echo sortie = $sortie
echo duree = $duree
echo

# }}}1

# Évaluation {{{1

# sox -V3 -m $court "| sox $court -p pad $delai" $long $sortie

evaluation="sox -S -V3 -m "

depart=$delai

while (( depart < duree ))
do
	evaluation+='-v 1 "'
	evaluation+="| sox $court -p pad $depart"
	evaluation+='" '
	(( depart += delai ))
done

evaluation+='-v 1 "'
evaluation+="| sox $court -p pad $duree"
evaluation+='" '

evaluation+="$long $sortie"

echo $evaluation
echo

eval $evaluation

# }}}1
