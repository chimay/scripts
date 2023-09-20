#! /usr/bin/env zsh

setopt extended_glob

#  {{{ Initialisation

integer temps=60

script=`basename $0`

#  }}}

# {{{ Arguments

while true
do
	case $1 in
		[0-9]##)
			temps=$1
			shift
			;;
		-[0-9]##)
			quantum=${1#-}
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
echo Temps : $temps
echo
echo Quantum : $quantum
echo

#  }}}

#  {{{ Self

[[ $0 = *${programme}* ]] && {

	echo "Le script ne peut se surveiller lui-même"
	echo

	exit 0
}

#  }}}

alias psgrep="ps auxww | grep -v grep | grep -v $script | grep"

sleep $temps

zenity --info --no-wrap --text "Le programme $programme va bientot s’arreter !" &

sleep $quantum

psgrep $programme && pkill -f $programme
