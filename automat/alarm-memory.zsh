#!/usr/bin/env zsh
# vim: set filetype=zsh:

zmodload zsh/mathfunc

# {{{ Fonctions

player () {

	local fu_volume=$1
	local fu_fichier=$2

	[[ $fu_fichier[1] != / ]] && {

		fu_fichier=~/audio/bell/$fu_fichier
	}

	mpv-socket.bash replace $fu_fichier
	mpv-socket.bash volume $fu_volume
}

# }}}

low=${1:-10}
volume=${2:-100}
fichier=~/audio/bell/notification/memoire.mp3

zzz=30

while true
do
	float available=$(free | grep Mem | awk '{print $7}')
	float total=$(free | grep Mem | awk '{print $2}')
	float used=$(free | grep Mem | awk '{print $2 - $7}')
	integer ratio_available=$(( available / total * 100 ))
	integer ratio_used=$(( used / total * 100 ))
	if (( ratio_available < low ))
	then
		echo playing $fichier
		echo
		player $volume $fichier
		zzz=4
	elif (( ratio_available < 2 * low ))
	then
		zzz=5
	else
		zzz=30
	fi
	echo available : $ratio_available %
	echo used : $ratio_used %
	echo sleep : $zzz seconds
	echo
	sleep $zzz
done
