#! /usr/bin/env zsh

setopt extended_glob

# {{{ Functions

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
	local fu_volume=$1
	local fu_fichier=$2
	mpv-socket.bash add $fu_fichier
	mpv-socket.bash volume 100
	echo
	#amixer -c 0 -- set Master -3dB
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
	echo frequency  : $frequency
	echo displace   : $displace
	echo ante       : $ante
	echo post       : $post
	echo chime      : $chime
	echo vocal      : $vocal
	echo volume     : $volume
	echo statusfile : $statusfile
	echo stamp      : $stamp
	echo pause      : $pause
	echo stop       : $stop
	echo
}

write-status-file () {
	local statusfile=$1
	local stamp=$2
	frequency=$(( 60 / interval ))
	cat <<- fin >| $statusfile
		interval = $interval
		displace = $displace
		ante = $ante
		post = $post
		chime = $chime
		vocal = $vocal
		volume = $volume
		statusfile = $statusfile
		stamp = $stamp
		pause = $pause
		stop = $stop
	fin
	touch $stamp
}

read-status-file () {
	local statusfile=$1
	local stamp=$2
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
	echo "clock is halting."
	echo
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
	echoerr
	echoerr "stop waiting"
	echoerr
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
	echoerr "halting clock"
	echoerr
	stop=1
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

integer interval=15
integer frequency=4
integer displace=0
integer ante=0
integer post=0
integer chime=2
integer vocal=0
integer volume=100
integer pause=0
integer stop=0

integer intmin

statusfile=~/racine/run/clock/clock.status

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
		+[0-9]##)
			interval=${1#+}
			frequency=$(( 60 / interval ))
			shift
			;;
		-[0-9]##)
			frequency=${1#-}
			interval=$(( 60 / frequency ))
			shift
			;;
		-d)
			shift
			displace=$1
			shift
			;;
		-a)
			shift
			ante=$1
			shift
			;;
		-p)
			shift
			post=$1
			shift
			;;
		+c)
			chime=2
			shift
			;;
		-c)
			shift
			chime=1
			;;
		-C)
			shift
			chime=0
			;;
		+v)
			vocal=2
			shift
			;;
		-v)
			vocal=1
			shift
			;;
		-V)
			vocal=0
			shift
			;;
		[0-9]##)
			volume=$1
			shift
			;;
		-i)
			shift
			statusfile=$1
			shift
			;;
		?*)
			shift
			;;
		*)
			break
			;;
	esac
done

# }}}

# Help {{{1

[ $numarg -eq 0 -o $aide -eq 1 ] && {
	echo "$(basename $0) : configurable clock."
	echo
	echo "Dependancies : audio files in ~/audio/bell/clock"
	echo
	echo "Usage : $(basename $0) options"
	echo
	echo "[Options]"
	echo
	echo "+interval : interval between chimes/vocals"
	echo "-frequency  : number of chimes/vocals per hour"
	echo "-d shift : chimes/vocals shift in minutes versus the hour start at 0 minute"
	echo "-a ante : also chime/vocal ante minutes before"
	echo "-p post : also chime/vocal post minutes after"
	echo "+c : long chime"
	echo "-c : short chime"
	echo "-C : no chime"
	echo "+v : long vocal"
	echo "-v : short vocal"
	echo "-V : no vocal"
	echo "volume (digits) : volume level"
	echo "-i status-file : file with status vars"
	exit 0
}

# }}}1

# Status file {{{1

stamp=${statusfile/.?*/.stamp}

[[ $statusfile = $stamp ]] && stamp=${stamp}.stamp

# }}}1

echo
echo '========================================================================'
date +"   clock starting %A %d %B %Y  (o) %H : %M : %S  | %:z | "
echo '========================================================================'
echo

write-status-file $statusfile $stamp

read-status-file $statusfile $stamp

trap 1>&2
echo

wait-until-next-minute

#  {{{ Loop

while true
do
	horodate
	[ $statusfile -nt $stamp ] && read-status-file $statusfile $stamp
	rest $pause
	halt $stop
	# variables
	bell=0
	# format 00 .. 23 & 00 .. 59
	hour=`date +%H`
	minute=`date +%M`
	# bell ?
	intmin=minute
	(( intmin = intmin - displace ))
	(( intmin % interval == 0 )) && bell=1
	# ante / post
	(( (intmin + ante) % interval == 0 )) && bell=1
	(( (intmin - post) % interval == 0 )) && bell=1
	# main bell
	(( bell == 1 )) && ring-bell $hour $minute
	# sync with minute start
	wait-until-next-minute
done

#  }}}
