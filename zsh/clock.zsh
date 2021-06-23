#! /usr/bin/env zsh

setopt extended_glob

#  {{{ Already running ?

grep="/bin/grep --color=never"

ps auxww | $=grep -v grep | $=grep -v $$ | $=grep clock.zsh && {

	echo "Clock already running."
	exit 0
}

#  }}}

#  {{{ Initialization

integer interval=15
integer frequency=4
integer displace=0
integer ante=0
integer post=0

integer chime=1
integer vocal=0

integer volume=100

integer pause=0
integer stop=0

integer hour minute
integer day_of_week=`date +%u`

statusfile=$HOME/racine/run/clock/clock.status

audiodir=$HOME/audio/sonnerie/horloge

rewind=$audiodir/rewind.ogg
tictac=$audiodir/tictac.ogg
simple_chime=$audiodir/coucou-1.ogg

#  }}}

# {{{ Arguments

while true
do
	case $1 in
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

# Status file {{{1

stamp=${statusfile/.?*/.stamp}

[[ $statusfile = $stamp ]] && stamp=${stamp}.stamp

# }}}1

# {{{ Functions

echoerr () {
	print "$@" >&2
}

lecteur () {

	local fu_volume=$1
	local fu_fichier=$2

	mpv-socket.bash add $fu_fichier
	mpv-socket.bash volume 100

	#amixer -c 0 -- set Master -3dB
}

horodate () {
	echo "------------------------------"
	echo
	date +"   [=] %A %d %B %Y  (o) %H : %M : %S  | %:z | "
	echo
}

read-status-file () {
	[[ $statusfile -nt $stamp ]] || return 0
	touch $stamp
	while read ligne
	do
		ligne=${ligne// }
		eval $ligne
	done < $statusfile
	echo "   interval = $interval"
	echo
	echo "   displace = $displace"
	echo
	echo "   Ante = $ante"
	echo "   Post = $post"
	echo
	echo "   chime = $chime"
	echo "   Vocal = $vocal"
	echo
	echo "   Volume = $volume"
	echo
	echo "   statusfile = $statusfile"
	echo "   stamp = $stamp"
	echo
	echo "   Pause = $pause"
	echo
	echo "   stop = $stop"
	echo
	echo "   lecteur $volume $rewind"
	echo "   lecteur $volume $tictac"
	echo
	lecteur $volume $rewind
	lecteur $volume $tictac
}

pause () {
	(( pause > 0 )) || return 0
	echo "    The clock is paused, sleeping 15 minutes."
	echo
	sleep 900
	seconds=`date +%S`
	delay=$(( 60 - seconds ))
	echo '   We are' $seconds 'late, we sleep' $delay 'seconds'
	echo
	sleep $delay
	continue
}

halt () {
	(( stop > 0 )) || return 0
	echo "Clock is halting."
	echo
	break
}

ring-bell () {
	(( chime == 2 )) && {
		cloche=$audiodir/chime-$hour-$minute.ogg
		[[ -f $cloche ]] || cloche=$audiodir/chime-HH-$minute.ogg
		[[ -f $cloche ]] || cloche=$audiodir/chime-HH-MM.ogg
		echo "   lecteur $volume $cloche"
		echo
		lecteur $volume $cloche
	}
	(( chime == 1 )) && {
		echo "   lecteur $volume $simple_chime"
		echo
		lecteur $volume $simple_chime
	}
	(( vocal == 2 )) && {
		voix=$audiodir/vocal-$hour-$minute.ogg
		[[ -f $voix ]] || voix=$audiodir/vocal-HH-$minute.ogg
		echo "   lecteur $volume $voix"
		echo
		lecteur $volume $voix
	}
	(( vocal == 1 )) && {
		voix=$audiodir/vocal-HH-$minute.ogg
		echo "   lecteur $volume $voix"
		echo
		lecteur $volume $voix
		#saytime
	}
	date +"   [=] %A %d %B %Y  (o) %H : %M : %S  | %:z | "
	echo
}

# }}}

# Traps {{{1

signal-stop-wait () {
	echoerr
	echoerr "stop waiting"
	echoerr
	[ -z $waiting ] || kill $waiting
}

signal-stop () {
	echoerr "halting wallpaper"
	echoerr

	stop=1

	cat <<- fin >| $statusfile
		dispersion = $dispersion
		minutes = $minutes
		seconds = $seconds
		meta = $meta
		current = $current
		reload = 0
		stop = 0
		statusfile = $statusfile
		stamp = $stamp
		logfile = $logfile
	fin

	touch $stamp

	exit 128
}

trap signal-stop-wait	SIGUSR1
trap signal-stop		SIGUSR2

trap signal-stop	HUP INT TERM

# }}}1

#  {{{ Initial display

echo
echo '========================================================================'
date +"   Démarrage le %A %d %B %Y  (o) %H : %M : %S  | %:z | "
echo '========================================================================'
echo

echo "   interval = $interval"
echo "   frequency = $frequency"
echo
echo "   displace = $displace"
echo
echo "   ante = $ante"
echo "   post = $post"
echo
echo "   chime = $chime"
echo "   vocal = $vocal"
echo
echo "   volume = $volume"
echo
echo "   statusfile = $statusfile"
echo "   stamp = $stamp"
echo
echo "   pause = $pause"
echo
echo "   stop = $stop"
echo
echo "   day = $day_of_week"
echo
trap 1>&2
echo

#  }}}

#  {{{ Status file init

cat <<- fin >| $statusfile

	# vim: set filetype=conf :

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

#  }}}

#  {{{ Initial delay

echo "   lecteur $volume $rewind"
echo "   lecteur $volume $tictac"
echo

lecteur $volume $rewind
lecteur $volume $tictac

seconds=`date +%S`

delay=$(( 60 - seconds ))

echo '   We are late of ' $seconds 'seconds, we sleep' $delay 'seconds'
echo

sleep $delay

#  }}}

#  {{{ Boucle

while true
do
	horodate
	read-status-file
	pause
	halt
	# Variables
	bell=0
	# Format 00 .. 23 & 00 .. 59
	hour=`date +%H`
	minute=`date +%M`
	day_of_week=`date +%u`
	# bell ?
	(( minute = minute - displace ))
	(( minute % interval == 0 )) && bell=1
	# ante / post
	(( (minute + ante) % interval == 0 )) && bell=1
	(( (minute - post) % interval == 0 )) && bell=1
	# main bell
	(( bell == 1 )) && ring-bell
	# Delay
	seconds=`date +%S`
	delay=$(( 60 - seconds ))
	echo '   We are' $seconds 'seconds late, we sleep' $delay 'seconds'
	echo
	sleep $delay &
	waiting=$!
	wait $waiting
done

#  }}}