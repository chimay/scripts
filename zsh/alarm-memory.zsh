#!/usr/bin/env zsh
# vim: set filetype=zsh:

zmodload zsh/mathfunc

# {{{ Fonctions

player () {

	local fu_volume=$1
	local fu_fichier=$2

	[[ $fu_fichier[1] != / ]] && {

		fu_fichier=~/audio/sonnerie/$fu_fichier
	}

	mpv-socket.bash replace $fu_fichier
	mpv-socket.bash volume $fu_volume
}

# }}}

low=${1:-10}
volume=${2:-100}
fichier=~/audio/sonnerie/notification/memoire.mp3

while true
do
	float available=$(free | grep Mem | awk '{print $7}')
	float total=$(free | grep Mem | awk '{print $2}')
	float used=$(free | grep Mem | awk '{print $2 - $7}')
	integer ratio_available=$(( available / total * 100 ))
	integer ratio_used=$(( used / total * 100 ))
	(( ratio_available < low )) && player $volume $fichier
	echo Available : $ratio_available %
	echo Used : $ratio_used %
	sleep 30
done
