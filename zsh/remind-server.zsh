#!/usr/bin/env /bin/zsh

await () {
	local delay=$1
	# so as not to delay traps interception
	sleep $delay &
	waitpid=$!
	wait $waitpid
}

signal-restart () {
	echo
	echo restarting remind ...
	echo
	kill $remindproc
}

reminders=~/racine/config/organizer/remind/reminders

# Number of minutes between remind checks
integer tictac=${1:-5}

integer minutes
integer modulo
integer future
integer epoch
integer future_epoch
integer delta

while true
do
	minutes=$(date +%M)
	modulo=$(( minutes % tictac ))

	if (( modulo > 0 ))
	then
		future=$(( tictac - modulo ))
	else
		future=0
	fi

	epoch=$(date +%s)
	future_epoch=$(date -d "$future min" +%s)
	(( future_epoch -= $(date -d "$future min" +%S) ))

	delta=$(( future_epoch - epoch ))
	(( delta < 0 )) && delta=0

	current_date=$(date -d @$epoch)
	future_date=$(date -d @$future_epoch)

	echo "tictac           = $tictac"
	echo "minutes          = $minutes"
	echo "modulo           = $modulo"
	echo "future           = $future"
	echo "epoch            = $epoch"
	echo "future_epoch     = $future_epoch"
	echo "delta            = $delta"
	echo "current_date     = $current_date"
	echo "future_date      = $future_date"
	echo

	trap '' SIGUSR1

	await $delta

	echo $(date) : Starting remind ...
	echo

	trap signal-restart SIGUSR1

	remind -z$tictac -k'remind-msg.sh %s &' $reminders &

	remindproc=$!

	echo remindproc = $remindproc
	echo

	wait $remindproc
done
