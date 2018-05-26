#! /usr/bin/env zsh

seuilAlerte=${1:-15}
seuilVeille=${2:-10}
seuilExtinction=${3:-5}

Nsonneries=${4:-5}

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

		if (( $minutes <= $seuilExtinction ))
		then
			echo
			echo "========================================================================"
			echo "  Il ne reste quasi rien : On éteint"
			echo "========================================================================"
			echo

			sync ; systemctl poweroff

		elif (( $minutes <= $seuilVeille ))
		then
			echo
			echo "========================================================================"
			echo "  Il ne reste plus beaucoup : Mise en veille"
			echo "========================================================================"
			echo

			sync ; systemctl suspend

		elif (( $minutes <= $seuilAlerte ))
		then

			notify-send -u critical -t 30000 "La batterie est faible !" &

			sync

			sonnerie.zsh $Nsonneries ~/audio/Sonnerie/notification/alarme-batterie.ogg &
		fi
	}

	sleep 60
done
