#! /usr/bin/env zsh

# REPL : Read Eval Print Loop
#
# Ctrl-D ou Ctrl-C pour interrompre la boucle

integer heu min sec

heu=0
min=1
sec=0

echo -n " <$(date +%H:%M)> Temps pour la minuterie ? [$min min] "

while read temps
do
	if (( $#temps == 0 ))
	then
		(( min += 1 ))
	else
		tableau=(${(s/:/)temps})

		if (( $#tableau == 3 ))
		then
			heu=$tableau[1]
			min=$tableau[2]
			sec=$tableau[3]

		elif (( $#tableau == 2 ))
		then
			min=$tableau[1]
			sec=$tableau[2]

		else
			min=$tableau[1]
		fi
	fi

	if (( heu > 0 && min > 0 && sec > 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong dans $heu heu $min min $sec sec"

	elif (( heu > 0 && min > 0 && sec == 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong dans $heu heu $min min"

	elif (( heu > 0 && min == 0 && sec > 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong dans $heu heu $sec sec"

	elif (( heu > 0 && min == 0 && sec == 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong dans $heu heu"

	elif (( heu == 0 && min > 0 && sec > 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong dans $min min $sec sec"

	elif (( heu == 0 && min > 0 && sec == 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong dans $min min"

	elif (( heu == 0 && min == 0 && sec > 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong dans $sec sec"

	else
		echo
		echo "	[$(date +%H:%M)] Ding dong maintenant"
	fi

	the.zsh $heu:$min:$sec &> /dev/null

	(( min += 1 ))

	if (( heu > 0 && min > 0 && sec > 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> Temps pour la minuterie ? [$heu heu $min min $sec sec] "

	elif (( heu > 0 && min > 0 && sec == 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> Temps pour la minuterie ? [$heu heu $min min] "

	elif (( heu > 0 && min == 0 && sec > 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> Temps pour la minuterie ? [$heu heu $sec sec] "

	elif (( heu > 0 && min == 0 && sec == 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> Temps pour la minuterie ? [$heu heu] "

	elif (( heu == 0 && min > 0 && sec > 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> Temps pour la minuterie ? [$min min $sec sec] "

	elif (( heu == 0 && min > 0 && sec == 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> Temps pour la minuterie ? [$min min] "

	elif (( heu == 0 && min == 0 && sec > 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> Temps pour la minuterie ? [$sec sec] "

	else
		echo
		echo -n " <$(date +%H:%M)> Temps pour la minuterie ? [$min min] "
	fi
done
