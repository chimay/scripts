#! /usr/bin/env zsh

# REPL : Read Eval Print Loop
#
# Ctrl-D ou Ctrl-C pour interrompre la boucle

integer min sec suivant

min=0
sec=0

suivant=1

echo -n " <$(date +%H:%M)> Temps pour la minuterie ? [$suivant min] "

while read temps
do
	if (( $#temps == 0 ))
	then
		(( min += 1 ))
	else
		minsec=(${(s/:/)temps})

		min=$minsec[1]

		sec=$minsec[2]
	fi

	temps=$min:$sec

	if (( sec > 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong dans $min min $sec sec"
	else
		echo
		echo "	[$(date +%H:%M)] Ding dong dans $min min"
	fi

	the.zsh $temps &> /dev/null

	(( suivant = min + 1 ))

	if (( sec > 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> Temps pour la minuterie ? [$suivant min $sec sec] "
	else
		echo
		echo -n " <$(date +%H:%M)> Temps pour la minuterie ? [$suivant min] "
	fi
done
