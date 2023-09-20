#! /usr/bin/env zsh

echo
echo "=================================="
echo " " $(date +"%H : %M %A %d %B %Y")
echo "=================================="
echo

alerte=${1:-30}
veille=${2:-15}
eteindre=${3:-5}
dodo=${4:-60}

echo  alerte   : $alerte minutes
echo  veille   : $veille minutes
echo  eteindre : $eteindre minutes
echo  dodo boucle : $dodo secondes
echo

echo "sleep $dodo"
echo

sleep $dodo

while true
do
	dateHeure=$(date +" %a %d %b %Y    %H:%M")

	batterie=`acpi -b`

	charge=`echo $batterie | awk '{ print $3 }' | sed "s/,//"`
	niveau=`echo $batterie | awk '{ print $4 }' | sed "s/,//"`
	temps=`echo $batterie | awk '{ print $5 }' | sed "s/,//"`

	if [[ $charge = Charging ]]
	then
		charge='++'
	elif [[ $charge = Full ]]
	then
		charge='::'
	elif [[ $charge = Discharging ]]
	then
		charge='--'
	fi

	Heur=`echo $temps | awk -F ':' '{ print $1 }'`
	Min=`echo $temps | awk -F ':' '{ print $2 }'`
	Sec=`echo $temps | awk -F ':' '{ print $3 }'`

	(( minutes = 60 * Heur + Min ))

	echo "$dateHeure  $niveau $charge $Heur : $Min"

	[[ $charge = -- ]] && {

		if (( $minutes <= $eteindre ))
		then
			echo "  Il ne reste quasi rien : On éteint"
			echo

			sync ; systemctl poweroff

		elif (( $minutes <= $veille ))
		then
			echo "  Il ne reste plus beaucoup : Mise en veille"
			echo

			sync ; systemctl suspend

		elif (( $minutes <= $alerte ))
		then

			notify-send -u critical -t 30000 "La batterie est faible !" &

			sync

			bell.zsh ~/audio/bell/notification/alarme-batterie.ogg &
		fi
	}

	sleep $dodo
done
