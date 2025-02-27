#! /usr/bin/env zsh

# Ring a bell & notify

setopt extended_glob

alias notify='notify-send -t 10000'

volume=70
Nbells=1

alarms=()
notifications=()

# arguments {{{1

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

# default {{{1

# Prefix ~/audio/bell/ added if needed

(( $#alarms == 0 )) && alarms=(notification/generique.ogg)

# fonctions {{{1

player () {
	local fu_volume=$1
	local fu_fichier=$2
	[[ $fu_fichier[1] != / ]] && {
		fu_fichier=~/audio/bell/$fu_fichier
	}
	mpv-socket.bash add $fu_fichier
	mpv-socket.bash volume $fu_volume
}

# affichage {{{1

temps=$(date +" [=] %A %d %B %Y  (o) %H:%M")

echo
echo "========================================================================"
echo "       Bell ($Nbells x), $temps"
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

# notifications {{{1

(( $#notifications > 0 )) && notify "$notifications"

# bell {{{1

for dring in $alarms
do
	for (( i = 0 ; i < Nbells ; i++ ))
	do
		echo "player $volume $dring"
		echo
		player $volume $dring
	done
done
