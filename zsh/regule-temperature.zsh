#!/usr/bin/env /bin/zsh

# /!\ Faire plus de tests

setopt extended_glob

alias psgrep='command ps -eo "%p %r" | command grep -v grep | command grep --color=never'

# Initialisation {{{1

local script=$$

local chaud=75

local delai=1

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

	for elt in $senseurs
	do
		(( elt > maximum )) && maximum=$elt
	done

	print "  " $maximum
	print

	groupe=($(ps -eo "%r %p" | \
		awk '{ if ( $2 == '$processus' ) print $1 }'
	))

	echo Groupe de processus : $groupe
	echo

	arbre=($(ps -eo "%r %p" | \
		awk '{ if ( $1 == '$groupe' && $2 != '$script' ) print $2 }'
	))

	echo Arbre des processus : $=arbre
	echo

	(( dodo == 0 )) && (( maximum > chaud )) && {

		echo Pause de $repos secondes
		echo
		echo "kill -STOP $=arbre"
		echo

		kill -STOP $=arbre

		dodo=1

		somme=0
	}

	(( dodo > 0 )) && {

		(( somme += delai ))

		echo Somme : $somme
		echo

		(( somme >= repos )) && {

			echo "kill -CONT $=arbre"
			echo

			kill -CONT $=arbre

			dodo=0

			somme=0
		}
	}

	sleep $delai
done

# }}}1
