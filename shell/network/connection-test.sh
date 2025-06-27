#!/usr/bin/env sh

temps=${1:-30}

volume=${2:-100}

echo temps = $temps
echo
echo volume = $volume
echo

# functions {{{1

lecteur () {
	fu_volume=$1
	fu_fichier=$2
	mpv-socket.bash add $fu_fichier > ~/log/mpv-socket.log 2>&1
	mpv-socket.bash volume $fu_volume > ~/log/mpv-socket.log 2>&1
}

# loop {{{1

while true
do
	ping -W 1 -c 1 archlinux.org > /dev/null 2>&1 && {
		echo " [$(date +%H:%M:%S)] Connexion établie"
		echo
		lecteur $volume ~/audio/bell/notification/connexion-etablie.ogg
		break
	}
	if ! ping -W 1 -c 1 192.168.1.1 > /dev/null 2>&1
	then
		echo " [$(date +%H:%M:%S)] Pas de connexion du tout"
		echo
		lecteur $volume ~/audio/bell/notification/pas-de-connexion.ogg
	else
		echo " [$(date +%H:%M:%S)] Connexion au routeur"
		echo
		lecteur $volume ~/audio/bell/notification/connexion-au-routeur.ogg
	fi
	sleep $temps
done
