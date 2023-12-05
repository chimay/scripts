#! /usr/bin/env zsh

setopt extended_glob

# {{{ Functions

help () {
	echo "$(basename $0) : configurable clock."
	echo
	echo "Dependancies : audio files in ~/audio/bell/clock"
	echo
	echo "Usage : $(basename $0) [status-file]"
	echo
	echo "[Status file format]"
	echo
	echo "variable = value"
	echo
	echo "Available variables"
	echo
	echo 'interval : time in minutes between chimes'
	echo 'first    : number of minutes of the first chime in the hour (defaults to zero)'
	echo 'ante     : number of minutes of the pre-chime ; 0 means no pre-chime'
	echo 'post     : number of minutes of the post-chime ; 0 means no post-chime'
	echo 'chime    : complexity of the instrumental chime : 2 means full, 1 simple, 0 for none'
	echo 'vocal    : complexity of the vocal chime : 2 means full, 1 simple, 0 for none'
	echo 'volume   : volume of chimes, between 0 and 100'
	echo 'pause    : whether to pause the clock ; it will only check for waking call every 15 minutes'
	echo 'stop     : whether to stop the clock'
	echo
	echo "[Signals]"
	echo
	echo "SIGUSR1        : stop the wait that syncs with minute start"
	echo "SIGUSR2        : toggle pause"
	echo "HUP, INT, TERM : save status in status file and stop"
	exit 0
}

await () {
	local delay=$1
	# so as not to delay traps interception
	sleep $delay &
	waitpid=$!
	wait $waitpid
}

echoerr () {
	print "$@" >&2
}

player () {
	local volume=$1
	local fichier=$2
	mpv-socket.bash add $fichier
	mpv-socket.bash volume $volume
	echo
}

horodate () {
	date +"[=] %A %d %B %Y  (o) %H : %M : %S  | %:z | "
	echo
}

wait-until-next-minute () {
	local seconds=`date +%S`
	local delay=$(( 60 - seconds ))
	[ $seconds -gt 0 ] && {
		echo We are $seconds seconds late, we sleep $delay seconds
		echo
	}
	await $delay
}

echo-status-vars () {
	echo interval   : $interval
	echo first      : $first
	echo ante       : $ante
	echo post       : $post
	echo chime      : $chime
	echo vocal      : $vocal
	echo volume     : $volume
	echo pause      : $pause
	echo stop       : $stop
	echo
}

write-status-file () {
	local statusfile=$1
	local stamp=$2
	echo "writing status file"
	echo
	cat <<- fin >| $statusfile
		interval = $interval
		first = $first
		ante = $ante
		post = $post
		chime = $chime
		vocal = $vocal
		volume = $volume
		pause = $pause
		stop = $stop
	fin
	touch $stamp
}

read-status-file () {
	local statusfile=$1
	local stamp=$2
	echo "reading status file"
	echo
	touch $stamp
	while read ligne
	do
		ligne=${ligne// }
		eval $ligne
	done < $statusfile
	echo-status-vars
	player $volume $rewind
	player $volume $tictac
	echo
}

rest () {
	local switch=$1
	(( switch > 0 )) || return 0
	echo "clock is paused, sleeping 15 minutes."
	echo
	await 900
	wait-until-next-minute
}

halt () {
	local halt=$1
	(( halt > 0 )) || return 0
	echo "halting wallpaper"
	echo
	stop=0
	write-status-file $statusfile $stamp
	break
}

ring-bell () {
	local hour=$1
	local minute=$2
	(( pause > 0 )) && return 0
	echo ringing at $hour:$minute
	echo
	(( chime == 2 )) && {
		cloche=$audiodir/chime-$hour-$minute.ogg
		[[ -f $cloche ]] || cloche=$audiodir/chime-HH-$minute.ogg
		[[ -f $cloche ]] || cloche=$audiodir/chime-HH-MM.ogg
		echo "player $volume $cloche"
		echo
		player $volume $cloche
	}
	(( chime == 1 )) && {
		echo "player $volume $simple_chime"
		echo
		player $volume $simple_chime
	}
	(( vocal == 2 )) && {
		voix=$audiodir/vocal-$hour-$minute.ogg
		[[ -f $voix ]] || voix=$audiodir/vocal-HH-$minute.ogg
		echo "player $volume $voix"
		echo
		player $volume $voix
	}
	(( vocal == 1 )) && {
		voix=$audiodir/vocal-HH-$minute.ogg
		echo "player $volume $voix"
		echo
		player $volume $voix
		#saytime
	}
}

# }}}

# Traps {{{1

signal-stop-wait () {
	echo
	echo "stop waiting"
	echo
	[ -z $waitpid ] || kill $waitpid
	waitpid=
}

signal-toggle () {
	# toggle active / paused
	if [ $pause -eq 0 ]
	then
		pause=1
	else
		pause=0
	fi
	write-status-file $statusfile $stamp
	signal-stop-wait
}

signal-stop () {
	echo "halting clock"
	echo
	stop=0
	write-status-file $statusfile $stamp
	signal-stop-wait
	exit 128
}

trap signal-stop-wait	SIGUSR1
trap signal-toggle		SIGUSR2

trap signal-stop	HUP INT TERM

# }}}1

#  {{{ Already running ?

grep="/bin/grep --color=never"

ps auxww | $=grep -v grep | $=grep -v $$ | $=grep clock.zsh && {

	echo "clock already running."
	exit 0
}

#  }}}

#  {{{ Initialization

statusfile=~/racine/run/clock/clock.status

integer interval=15
integer first=0
integer ante=0
integer post=0
integer chime=2
integer vocal=0
integer volume=100
integer pause=0
integer stop=0

integer intmin intmodulo

audiodir=~/audio/bell/clock

rewind=$audiodir/rewind.ogg
tictac=$audiodir/tictac.ogg
simple_chime=$audiodir/coucou-1.ogg

#  }}}

# {{{ Arguments

numarg=$#

aide=0

while true
do
	case $1 in
		-h)
			aide=1
			break
			;;
		?*)
			statusfile=$1
			shift
			;;
		*)
			break
			;;
	esac
done

# }}}

# Status file {{{1

stamp=${statusfile/.?*/.stamp}

[[ $statusfile = $stamp ]] && stamp=${stamp}.stamp

touch $statusfile

# }}}1

[ $numarg -eq 0 -o $aide -eq 1 ] && help

echo
echo '========================================================================'
date +"   clock starting %A %d %B %Y  (o) %H : %M : %S  | %:z | "
echo '========================================================================'
echo
echo statusfile : $statusfile
echo stamp : $stamp
echo

read-status-file $statusfile $stamp

trap 1>&2
echo

wait-until-next-minute

#  {{{ Loop

while true
do
	horodate
	[ $statusfile -nt $stamp ] && read-status-file $statusfile $stamp
	echo-status-vars
	rest $pause
	halt $stop
	# variables
	bell=0
	# format 00 .. 23 & 00 .. 59
	hour=`date +%H`
	minute=`date +%M`
	# bell ?
	(( intmin = minute - first ))
	(( intmodulo = intmin % interval ))
	(( intmodulo == 0 )) && bell=1
	echo intmin : $intmin
	echo intmodulo : $intmodulo
	echo
	# ante / post
	(( (intmin + ante) % interval == 0 )) && bell=1
	(( (intmin - post) % interval == 0 )) && bell=1
	# main bell
	(( bell == 1 )) && ring-bell $hour $intmin
	# sync with minute start
	wait-until-next-minute
done

#  }}}
