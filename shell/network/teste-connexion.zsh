#!/usr/bin/env zsh

temps=${1:-30}

volume=${2:-70}

echo temps = $temps
echo
echo volume = $volume
echo

# {{{ Fonctions

lecteur () {

	local fu_volume=$1
	local fu_fichier=$2

	[[ $fu_fichier[1] != / ]] && {

		fu_fichier=~/audio/bell/$fu_fichier
	}

	mpv-socket.bash add $fu_fichier
	mpv-socket.bash volume $fu_volume
}

browser () {
	local agent="User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36"
	wget -U $agent -O - "$@"
	#curl -A $agent "$@"

}

# }}}

browser archlinux.org
exit

# Boucle {{{1

while true
do
	# ! wget -O - www.google.com | grep 192.168.1.1

	if ! browser www.google.com &> /dev/null
	then
		echo " [$(date +%H:%M:%S)] Pas de connexion du tout"
		echo

		lecteur $volume ~/audio/bell/notification/connexion-0.ogg

		sleep $temps

		continue
	fi

	if ! browser www.google.com 2>/dev/null | grep 192.168.1.1 &> /dev/null
	then
		break
	fi

	echo " [$(date +%H:%M:%S)] Connexion au routeur"
	echo

	lecteur $volume ~/audio/bell/notification/connexion-routeur.ogg

	sleep $temps
done

# }}}1

echo " [$(date +%H:%M:%S)] Connexion établie"
echo

lecteur $volume ~/audio/bell/notification/connexion-etablie.ogg

exit 0
