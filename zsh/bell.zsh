#! /usr/bin/env zsh

# Ring a bell & notify

setopt extended_glob

alias notify='notify-send -t 10000'

volume=100
Nbells=1

alarms=()
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
			Nbells=${1#*\=}
			shift
			;;
		?*)
			alarms+=$1
			shift
			;;
		*)
			break
			;;
	esac
done

# }}}

# {{{ Default

# Prefix ~/audio/sonnerie/ added if needed

(( $#alarms == 0 )) && alarms=(notification/generique.ogg)

# }}}

# {{{ Fonctions

lecteur () {
	local fu_volume=$1
	local fu_fichier=$2
	[[ $fu_fichier[1] != / ]] && {
		fu_fichier=~/audio/sonnerie/$fu_fichier
	}
	mpv-socket.bash add $fu_fichier
	mpv-socket.bash volume $fu_volume
}

# }}}

# {{{ Affichage

temps=$(date +" [=] %A %d %B %Y  (o) %H:%M")

echo
echo "========================================================================"
echo "       Sonnerie ($Nbells x) le $temps"
echo "========================================================================"
echo
echo volume : $volume
echo
echo Nbells : $Nbells
echo
echo alarms : $alarms
echo
echo notifications : $notifications
echo

# }}}

# {{{ Notifications

(( $#notifications > 0 )) && notify "$notifications"

# }}}

# {{{ Bell

for dring in $alarms
do
	for (( i = 0 ; i < Nbells ; i++ ))
	do
		echo "lecteur $volume $dring"
		echo
		lecteur $volume $dring
	done
done

# }}}
