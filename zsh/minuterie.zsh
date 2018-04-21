#! /usr/bin/env zsh

setopt extended_glob

#{

minutes=0
secondes=0

arguments=()

while true
do
	case $1 in

		[0-9]##)
			minutes=$1
			shift
			;;

		-[0-9]##)
			secondes=${1#-}
			shift
			;;

		[0-9]##:[0-9]##)
			minutes=${1%:*}
			secondes=${1#*:}
			shift
			;;
		?*)
			arguments+=$1
			shift
			;;
		*)
			break
	esac
done

total=`expr $minutes '*' 60 + $secondes`

echo "$minutes minutes $secondes secondes =  $total secondes"
echo

notify-send -t 10000 "Minuterie : $minutes minutes et $secondes secondes." &

sleep $total

echo "sonnerie.zsh $=arguments"
echo

sonnerie.zsh $=arguments

notify-send -t 30000 "La minuterie a sonné !" &

#} &!
