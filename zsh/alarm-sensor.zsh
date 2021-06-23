#!/usr/bin/env zsh

setopt extended_glob

# Initialisation {{{1

local chaud=75
local tres_chaud=80

local temps=10

local volume=100

# }}}1

# Aide {{{1

[ $# -eq 0 ] && {

	echo Usage : ${0##*/} +chaud ++tres_chaud -temps volume
	echo
	echo "Par défaut :"
	echo
	echo Chaud : $chaud
	echo Très chaud : $tres_chaud
	echo Temps : $temps
	echo Volume : $volume

	exit
}

[ $# -gt 0 ] && [ $1 = help -o $1 = -h -o $1 = --help ] && {

	echo Usage : ${0##*/} +chaud ++tres_chaud -temps volume
	echo
	echo "Par défaut :"
	echo
	echo Chaud : $chaud
	echo Très chaud : $tres_chaud
	echo Temps : $temps
	echo Volume : $volume

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
		++[0-9]##)
			tres_chaud=${1#++}
			shift
			;;
		-[0-9]##)
			temps=${1#-}
			shift
			;;
		[0-9]##)
			volume=$1
			shift
			;;
		?*)
			shift
			;;
		*)
			break
			;;
	esac
done

# }}}

# Affichage {{{1

print Chaud : $chaud
print
print Très chaud : $tres_chaud
print
print Temps : $temps
print
print Volume : $volume
print

# }}}1

# {{{ Fonctions

lecteur () {

	local fu_volume=$1
	local fu_fichier=$2

	[[ $fu_fichier[1] != / ]] && {

		fu_fichier=~/audio/bell/$fu_fichier
	}

	mpv-socket.bash replace $fu_fichier
	mpv-socket.bash volume $fu_volume
}

# }}}

# Boucle {{{1

while true
do
	echo "== $(date +%T) =="

	print

# 	senseurs=($(sensors | \
# 		grep -E '(temp|Core)[^(]+°C' | \
# 		sed 's/(.*)//' | \
# 		sed 's/°C//' | \
# 		sed 's/+//' | \
# 		sed 's/^temp[0-9]:\s\+//' | \
# 		sed 's/^Core [0-9]:\s\+//' \
# 	))

	senseurs=($(sensors | \
		grep -E 'Core[^(]+°C' | \
		sed 's/(.*)//' | \
		sed 's/°C//' | \
		sed 's/+//' | \
		sed 's/^temp[0-9]:\s\+//' | \
		sed 's/^Core [0-9]:\s\+//' \
	))

	#print -l $=senseurs
	#print

	maximum=0

	for elt in $senseurs
	do
		(( elt > maximum )) && maximum=$elt
	done

	print "  " $maximum
	print

	(( maximum >= tres_chaud )) && {

		echo "lecteur $volume ~/audio/bell/notification/cpu-tres-chaud.ogg"
		echo

		lecteur $volume ~/audio/bell/notification/cpu-tres-chaud.ogg

		sleep 3

		continue
	}

	(( maximum >= chaud )) && {

		echo "lecteur $volume ~/audio/bell/notification/cpu-chaud.ogg"
		echo

		lecteur $volume ~/audio/bell/notification/cpu-chaud.ogg

		sleep 3

		continue
	}

	sleep $temps
done

# }}}1
