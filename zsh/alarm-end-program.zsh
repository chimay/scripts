#! /usr/bin/env zsh

setopt extended_glob

#  {{{ Initialisation

persistant=0

integer quantum=60
integer volume=100

script=`basename $0`

fini=$HOME/audio/bell/notification/fini.ogg

#  }}}

# {{{ Arguments

while true
do
	case $1 in
		-p)
			persistant=1
			shift
			;;
		-[0-9]##)
			quantum=${1#-}
			shift
			;;
		[0-9]##)
			volume=$1
			shift
			;;
		?*)
			programme=$1
			shift
			;;
		*)
			break
			;;
	esac
done

# }}}

#  {{{ Affichage

echo Programme : $programme
echo
echo Script : $script
echo
echo Persistant : $persistant
echo
echo Quantum : $quantum
echo
echo Volume : $volume
echo

#  }}}

# {{{ Fonctions

player () {

	local fu_volume=$1
	local fu_fichier=$2

	[[ $fu_fichier[1] != / ]] && {

		fu_fichier=~/audio/bell/$fu_fichier
	}

	mpv-socket.bash add $fu_fichier
	mpv-socket.bash volume $fu_volume
}

# }}}

#  {{{ Self

[[ $0 = *${programme}* ]] && {

	echo "Le script ne peut se surveiller lui-même"
	echo
	echo "	  player $volume $fini"
	echo

	player $volume $fini

	exit 0
}

#  }}}

alias psgrep="ps auxww | grep -v grep | grep -v $script | grep"

while true
do
	date +"   [=] %A %d %B %Y  (o) %H : %M : %S  | %:z | "
	echo

	psgrep $programme &>| /dev/null || {

		echo "	  player $volume $fini"
		echo

		player $volume $fini

		(( persistant == 0 )) && break
	}

	sleep $quantum
done
