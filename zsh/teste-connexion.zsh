#!/usr/bin/env /bin/zsh

temps=${1:-30}

volume=${2:-10}

echo temps = $temps
echo
echo volume = $volume
echo

# {{{ Fonctions

lecteur () {

	local fu_volume=$1
	local fu_fichier=$2

	echo "loadfile $fu_fichier 1" > ~/racine/run/fifo/mplayer

	echo "set volume $fu_volume" > ~/racine/run/fifo/mplayer
}

# }}}

# Boucle {{{1


while true
do
	# ! wget -O - www.google.com | grep LAN_ROUTER_IP

	if ! curl www.google.com &> /dev/null
	then
		echo " [$(date +%H:%M:%S)] Pas de connexion du tout"
		echo

		lecteur $volume ~/audio/Sonnerie/notification/connexion-0.ogg

		sleep $temps

		continue
	fi

	if ! curl www.google.com 2>/dev/null | grep LAN_ROUTER_IP &> /dev/null
	then
		break
	fi

	echo " [$(date +%H:%M:%S)] Connexion au routeur"
	echo

	lecteur $volume ~/audio/Sonnerie/notification/connexion-routeur.ogg

	sleep $temps
done

# }}}1

echo " [$(date +%H:%M:%S)] Connexion établie"
echo

lecteur $volume ~/audio/Sonnerie/notification/connexion-etablie.ogg
