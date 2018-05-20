#!/usr/bin/env /bin/zsh

# /!\ Faire plus de tests

setopt extended_glob

alias psgrep='command ps -eo "%p %r" | command grep -v grep | command grep --color=never'

# Fonctions {{{1

# Credits :
# https://stackoverflow.com/questions/392022/whats-the-best-way-to-send-a-signal-to-all-members-of-a-process-group/6481337

signal-arbre () {
    local _pid=$1
    local _sig=${2:--STOP}

	 # needed to stop quickly forking parent from producing children
	 # between child killing and parent killing

    kill -stop ${_pid}

	for _child in $(ps -o pid --no-headers --ppid ${_pid})
	do
        signal-arbre ${_child} ${_sig}
    done

    kill -${_sig} ${_pid}
}

# }}}1

# Initialisation {{{1

script=$$

chaud=75

delai=1

# }}}1

# {{{ Arguments

while true
do
	case $1 in
		[0-9]##)
			chaud=$1
			shift
			;;
		-[0-9]##)
			delai=${1#-}
			shift
			;;
		+[0-9]##)
			repos=${1#+}
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

# Groupe de processus

groupe=($(ps -eo "%r %p" | awk '{ if ( $2 == '$processus' ) print $1 }'))

echo Groupe de processus : $groupe
echo

# }}}1

# Affichage {{{1

print Chaud : $chaud
print
print delai : $delai
print
print Commande : $=commande
print
print Processus : $processus
print
print Journal : $journal
print


# }}}1

# Boucle {{{1

dodo=0

while true
do
	echo Dodo : $dodo
	echo

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

	(( dodo == 0 )) && (( maximum > chaud )) && {

		echo Pause de $repos secondes
		echo
		echo "signal-arbre $processus STOP"
		echo

		signal-arbre $processus STOP

		dodo=1

		somme=0
	}

	(( dodo > 0 )) && {

		(( somme += delai ))

		echo Somme : $somme
		echo

		(( somme >= repos )) && {

			echo On reprend
			echo
			echo "signal-arbre $processus CONT"
			echo

			signal-arbre $processus CONT

			dodo=0

			somme=0
		}
	}

	sleep $delai
done

# }}}1
