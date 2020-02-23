#!/usr/bin/env /bin/zsh

# vim: set filetype=zsh:

# Fonctions {{{1

signal-restart () {
	echo
	echo Restarting remind ...
	echo
	kill $remindproc
}

# }}}1

# Number of minutes between remind checks
integer tictac=${1:-5}

integer minutes
integer modulo
integer futur
integer epoque
integer epoque_future
integer delta

while true
do
	minutes=$(date +%M)
	modulo=$(( minutes % tictac ))

	if (( modulo > 0 ))
	then
		futur=$(( tictac - modulo ))
	else
		futur=0
	fi

	epoque=$(date +%s)
	epoque_future=$(date -d "$futur min" +%s)
	(( epoque_future -= $(date -d "$futur min" +%S) ))

	delta=$(( epoque_future - epoque ))
	(( delta < 0 )) && delta=0

	date_courante=$(date -d @$epoque)
	date_future=$(date -d @$epoque_future)

	fichier=~/racine/config/organizer/remind/reminders

	echo "tictac           = $tictac"
	echo "minutes          = $minutes"
	echo "modulo           = $modulo"
	echo "futur            = $futur"
	echo "epoque           = $epoque"
	echo "epoque_future    = $epoque_future"
	echo "delta            = $delta"
	echo "date_courante    = $date_courante"
	echo "date_future      = $date_future"
	echo

	trap '' SIGUSR1

	sleep $delta &

	attendre=$!

	echo attendre = $attendre
	echo

	wait $attendre

	echo $(date) : Starting remind ...
	echo

	trap signal-restart SIGUSR1

	remind -z$tictac -k'remind-msg.sh %s &' $fichier &

	remindproc=$!

	echo remindproc = $remindproc
	echo

	wait $remindproc
done
