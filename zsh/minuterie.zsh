#! /usr/bin/env zsh

setopt extended_glob

#{

heures=0
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
		[0-9]##:[0-9]##)
			minutes=${1%:*}
			secondes=${1#*:}
			shift
			;;
		[0-9]##:[0-9]##:[0-9]##)
			temps=(${(s/:/)1})
			heures=$temps[1]
			minutes=$temps[2]
			secondes=$temps[3]
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

total=$(expr $heures '*' 3600 + $minutes '*' 60 + $secondes)

if (( heures > 0 && minutes > 0 && secondes > 0 ))
then
	echo "$heures heures $minutes minutes $secondes secondes =  $total secondes"
	echo
	notify-send -t 10000 "Minuterie : $heures heu $minutes min $secondes sec" &

elif (( heures > 0 && minutes > 0 && secondes == 0 ))
then
	echo "$heures heures $minutes minutes =  $total secondes"
	echo
	notify-send -t 10000 "Minuterie : $heures heu $minutes min" &

elif (( heures > 0 && minutes == 0 && secondes > 0 ))
then
	echo "$heures heures $secondes secondes =  $total secondes"
	echo
	notify-send -t 10000 "Minuterie : $heures heu $secondes sec" &

elif (( heures > 0 && minutes == 0 && secondes == 0 ))
then
	echo "$heures heures =  $total secondes"
	echo
	notify-send -t 10000 "Minuterie : $heures heu" &

elif (( heures == 0 && minutes > 0 && secondes > 0 ))
then
	echo "$minutes minutes $secondes secondes =  $total secondes"
	echo
	notify-send -t 10000 "Minuterie : $minutes min $secondes sec" &

elif (( heures == 0 && minutes > 0 && secondes == 0 ))
then
	echo "$minutes minutes =  $total secondes"
	echo
	notify-send -t 10000 "Minuterie : $minutes min" &

elif (( heures == 0 && minutes == 0 && secondes > 0 ))
then
	echo "$secondes secondes =  $total secondes"
	echo
	notify-send -t 10000 "Minuterie : $secondes sec" &

else
	echo "Minuterie instantanée"
	echo
	notify-send -t 10000 "Minuterie instantanée" &
fi

sleep $total

echo "sonnerie.zsh $=arguments"
echo

sonnerie.zsh $=arguments

notify-send -t 30000 "La minuterie a sonné !" &

#} &!
