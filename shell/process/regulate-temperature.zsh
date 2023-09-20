#!/usr/bin/env zsh

# /!\ Faire plus de tests

setopt extended_glob

alias psgrep='command ps -eo "%p %r" | command grep -v grep | command grep --color=never'

# Fonctions {{{1

# Credits :
# https://stackoverflow.com/questions/392022/whats-the-best-way-to-send-a-signal-to-all-members-of-a-process-group/6481337

signal-arbre () {

    local iden=$1
    local signal=${2:--STOP}

	 # needed to stop quickly forking parent from producing children
	 # between child killing and parent killing

    kill -stop $iden

	for enfant in $(ps -o pid --no-headers --ppid $iden)
	do
        signal-arbre $enfant $signal
    done

    kill -$signal $iden
}

# }}}1

# Initialisation {{{1

chaud=80

froid=70

delai_eveil=1

delai_dodo=5

# }}}1

# Aide {{{1

[ $# -eq 0 ] && {

	echo Usage : ${0##*/} +chaud -froid delai_eveil-delai_dodo commande
	echo
	echo "Par défaut :"
	echo
	echo Chaud = $chaud
	echo
	echo Froid = $froid
	echo
	echo Delai éveil = $delai_eveil
	echo
	echo Delai dodo = $delai_dodo
	echo

	exit
}

[ $# -gt 0 ] && [ $1 = help -o $1 = -h -o $1 = --help ] && {

	echo Usage : ${0##*/} +chaud -froid delai_eveil-delai_dodo commande
	echo
	echo "Par défaut :"
	echo
	echo Chaud = $chaud
	echo
	echo Froid = $froid
	echo
	echo Delai éveil = $delai_eveil
	echo
	echo Delai dodo = $delai_dodo
	echo

	exit
}

# }}}1

# {{{ Arguments

while true
do
	case $1 in
		+[0-9]##)
			chaud=${1#+}
			shift
			;;
		-[0-9]##)
			froid=${1#-}
			shift
			;;
		[0-9]##-[0-9]##)
			delai_eveil=${1%-*}
			delai_dodo=${1#*-}
			shift
			;;
		[0-9]##)
			delai_eveil=$1
			(( delai_dodo = 2 * delai_eveil ))
			shift
			;;
		*)
			break
			;;
	esac
done

commande=("$@")

# }}}

# Lancement de la commande {{{1

journal=regule-temp-${(j:_:)commande}

$=commande &>! ~/log/$journal &

processus=$!

# }}}1

# Affichage {{{1

print Chaud : $chaud
print
print Froi : $froid
print
print Delai éveil : $delai_eveil
print
print Delai dodo : $delai_dodo
print
print Commande : $=commande
print
print Processus : $processus
print
print Journal : $journal
print

# }}}1

# Boucle {{{1

eveil=1

while true
do
	if (( eveil == 1 ))
	then
		echo "==== Mode éveil ===="
		echo
		echo "sleep $delai_eveil"
		echo

		sleep $delai_eveil
	else
		echo "==== Mode dodo  ===="
		echo
		echo "sleep $delai_dodo"
		echo

		sleep $delai_dodo
	fi

	psgrep $processus &> /dev/null || break

	senseurs=($(sensors | \
		grep -E '(temp|Core)[^(]+°C' | \
		sed 's/(.*)//' | \
		sed 's/°C//' | \
		sed 's/+//' | \
		sed 's/^temp[0-9]:\s\+//' | \
		sed 's/^Core [0-9]:\s\+//' \
	))

	maximum=0

	for temperature in $senseurs
	do
		(( temperature > maximum )) && maximum=$temperature
	done

	print Temperature maximale : $maximum
	print

	if (( eveil == 1 ))
	then
		(( maximum >= chaud )) && {

			echo "signal-arbre $processus STOP"
			echo

			signal-arbre $processus STOP

			eveil=0
		}
	else
		(( maximum <= froid )) && {

			echo "signal-arbre $processus CONT"
			echo

			signal-arbre $processus CONT

			eveil=1
		}
	fi
done

# }}}1
