#!/usr/bin/env /bin/zsh

# remind-server.zsh [reminders-file] [tictac]
# where tictac is the number of minutes between remind checks

reminders=${1:-~/racine/config/organizer/remind/reminders}

integer tictac=${2:-5}

integer minutes
integer modulo
integer future
integer epoch
integer future_epoch

await () {
	local delay=$1
	# so as not to delay traps interception
	sleep $delay &
	waitpid=$!
	wait $waitpid
}

stop-wait () {
	echoerr "stop waiting"
	echoerr
	[ -z $waitpid ] || kill $waitpid
	waitpid=
}

echoerr () {
	print "$@" >&2
}

display-info () {
	local current_date=$(date -d @$epoch)
	local future_date=$(date -d @$future_epoch)
	echoerr "minutes          = $minutes"
	echoerr "modulo           = $modulo"
	echoerr "future           = $future"
	echoerr "epoch            = $epoch"
	echoerr "future_epoch     = $future_epoch"
	echoerr "delta            = $delta"
	echoerr "current_date     = $current_date"
	echoerr "future_date      = $future_date"
	echoerr
}

delta-until-good-time () {
	local delta
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
	# some info to display
	display-info
	# result
	echo $delta
}

wait-until-good-time () {
	echo $(date) : waiting for the good time to restart remind ...
	echo
	trap '' SIGUSR1
	trap 1>&2
	echo
	await $(delta-until-good-time)
}

start-remind () {
	echo $(date) : starting remind ...
	echo
	trap restart-remind SIGUSR1
	trap 1>&2
	remind -z$tictac -k'remind-msg.sh %s &' $reminders &
	remindproc=$!
	echo remindproc = $remindproc
	echo
	wait $remindproc
}

restart-remind () {
	echo
	echo restarting remind ...
	echo
	kill $remindproc
	remindproc=
}

while true
do
	wait-until-good-time
	start-remind
done
