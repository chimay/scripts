#! /usr/bin/env zsh

setopt extended_glob

volume=10

Nsonneries=1

alarmes=()

# {{{ Arguments

while true
do
	case $1 in
		vol*=?*)
			volume=${1#*\=}
			shift
			;;
		rep*=?*)
			Nsonneries=${1#*\=}
			shift
			;;
		?*)
			alarmes+=$1
			shift
			;;
		*)
			break
			;;
	esac
done

# }}}

(( $#alarmes == 0 )) && alarmes=(~/audio/Sonnerie/notification/generique.ogg)

# Aliases {{{1

alias psgrep="ps auxww | grep -v grep | grep --color=never"

# }}}1

# {{{ Fonctions

lecteur () {

	local fu_volume=$1
	local fu_fichier=$2

	echo "loadfile $fu_fichier 1" > ~/racine/run/fifo/mplayer

	echo "set volume $fu_volume" > ~/racine/run/fifo/mplayer
}

# }}}

temps=$(date +" [=] %A %d %B %Y  (o) %H:%M")

echo
echo "========================================================================"
echo "       Sonnerie ($Nsonneries x) le $temps"
echo "========================================================================"
echo

for dring in $alarmes
do
	for (( i = 0 ; i < Nsonneries ; i++ ))
	do
		echo "lecteur $volume $dring"
		echo

		lecteur $volume $dring

		sleep 1
	done
done
