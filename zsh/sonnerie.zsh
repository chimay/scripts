#! /usr/bin/env zsh

setopt extended_glob

alias notifie='notify-send -t 10000'

volume=100

Nsonneries=1

alarmes=()

notifications=()

# {{{ Arguments

while true
do
	case $1 in
		n*=?*)
			notifications+=${1#*\=}
			shift
			;;
		v*=?*)
			volume=${1#*\=}
			shift
			;;
		re*=?*)
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

# {{{ Défaut

# Préfixe ~/audio/Sonnerie/ ajouté au besoin

(( $#alarmes == 0 )) && alarmes=(notification/generique.ogg)

# }}}

# Aliases {{{1

alias psgrep="ps auxww | grep -v grep | grep --color=never"

# }}}1

# {{{ Fonctions

lecteur () {

	local fu_volume=$1
	local fu_fichier=$2

	[[ $fu_fichier[1] != / ]] && {

		fu_fichier=~/audio/Sonnerie/$fu_fichier
	}

	# echo fu_fichier : $fu_fichier
	# echo

	echo "loadfile $fu_fichier append-play" > ~/racine/run/fifo/mpv

	echo "set volume $fu_volume" > ~/racine/run/fifo/mpv
}

# }}}

# {{{ Affichage

temps=$(date +" [=] %A %d %B %Y  (o) %H:%M")

echo
echo "========================================================================"
echo "       Sonnerie ($Nsonneries x) le $temps"
echo "========================================================================"
echo
echo Volume : $volume
echo
echo Nsonneries : $Nsonneries
echo
echo Alarmes : $alarmes
echo
echo Notifications : $notifications
echo

# }}}

# {{{ Notifications

(( $#notifications > 0 )) && notifie "$notifications"

# }}}

# {{{ Sonnerie

for dring in $alarmes
do
	for (( i = 0 ; i < Nsonneries ; i++ ))
	do
		echo "lecteur $volume $dring"
		echo

		lecteur $volume $dring
	done
done

# }}}
