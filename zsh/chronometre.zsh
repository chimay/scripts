#! /usr/bin/env zsh

setopt extended_glob

echo Use Ctrl-C to quit
echo

seconde=0
minute=0
heure=0

echo '\t' 0
echo

sleep 1

while true
do
	(( seconde += 1 ))

	echo -n '\t' $seconde

	(( seconde % 12 == 0 )) && echo

	(( seconde > 0 )) && (( seconde % 60 == 0 )) && {

		seconde=0

		(( minute += 1 ))

		echo
		echo $heure heu $minute min
		echo
	}

	(( minute > 0 )) && (( minute % 60 == 0 )) && {

		minute=0

		(( heure += 1 ))

		echo
		echo $heure heu $minute min
		echo
	}

	sleep 1
done
