#! /usr/bin/env zsh

# REPL : Read Eval Print Loop
#
# Ctrl-D ou Ctrl-C pour interrompre la boucle

# TRAPINT {{{1

TRAPINT () {

	echo
	echo
	echo "On arrête ..."
	echo

	exit 128
}

# }}}1

# Initialisation {{{1

integer heu min sec

heu=0
min=1
sec=0

# }}}1

echo -n " <$(date +%H:%M)> Temps pour la minuterie ? [$min min] "

while read temps
do
	# Entrée {{{1

	if (( $#temps > 0 ))
	then
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

			heu=0
		else
			min=$tableau[1]

			heu=0
			sec=0
		fi
	fi

	# }}}1

	# Format canonique {{{1

	integer quotient modulo

	# N x 60 secondes -> N minutes

	(( quotient = sec / 60 ))
	(( modulo = sec % 60 ))

	(( min += quotient ))
	(( sec = modulo ))

	# N x 60 minutes -> N heures

	(( quotient = min / 60 ))
	(( modulo = min % 60 ))

	(( heu += quotient ))
	(( min = modulo ))

	# }}}1

	# Affichage {{{1

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

	# }}}1

	the.zsh $heu:$min:$sec &> /dev/null

	(( min += 1 ))

	# Prompt {{{1

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

	# }}}1

done
