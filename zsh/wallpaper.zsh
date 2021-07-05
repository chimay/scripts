#! /usr/bin/env zsh

# {{{ Options

setopt null_glob
setopt extended_glob

# }}}

# Functions {{{1

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
}

echoerr () {
	print "$@" >&2
}

echo-status-vars () {
	echoerr status file : $statusfile
	echoerr stamp file  : $stamp
	echoerr meta        : $meta
	echoerr logfile     : $logfile
	echoerr dispersion  : $dispersion
	echoerr minutes     : $minutes
	echoerr seconds     : $seconds
	echoerr delay       : $delay
	echoerr current     : $current
	echoerr reload      : $reload
	echoerr stop        : $stop
	echoerr
}

write-status-file () {
	local statusfile=$1
	cat <<- fin >| $statusfile
		statusfile = $statusfile
		stamp = $stamp
		meta = $meta
		logfile = $logfile
		dispersion = $dispersion
		minutes = $minutes
		seconds = $seconds
		current = $current
		reload = 0
		stop = 0
	fin
	touch $stamp
}

read-status-file () {
	local statusfile=$1
	[[ -f $statusfile ]] || write-status-file $statusfile
	touch $stamp
	while read ligne
	do
		ligne=${ligne// }
		eval $ligne
	done < $statusfile
	(( delay = minutes * 60 + seconds ))
	echo-status-vars
}

choose-wallpaper () {
	while [ ! -e $images[$current] -a $current -lt $Nimages ]
	do
		echoerr file $images[$current] does not exist : skipping
		echoerr
		(( current += 1 ))
	done
	if (( current < Nimages ))
	then
		poster=$images[$current]
	else
		reload=1
	fi
}

regen-image-list () {
	local reload=$1
	if (( reload == 1 ))
	then
		gen-random-list.zsh $dispersion $meta &>>! ~/log/gen-random-list.log
		images=($(cat $liste))
		current=1
		Nimages=${#images}
		poster=$images[$current]
	fi
	reload=0
}

horodate () {
	dateHeure=`date +"%a %d %b %Y, %H:%M"`
	echoerr $dateHeure : $current : $poster
}

change-wallpaper () {
	feh --bg-max --no-fehbg $poster
}

symlink () {
	# Pour i3lock
	link=${statusfile%/*}/current
	[ -L $link ] && {
		#echoerr "rm -f $link"
		#echoerr
		rm -f $link
	}
	ln -s $poster $link
}

# }}}1

# Traps {{{1

signal-reload () {
	echoerr "reloading wallpapers list"
	echoerr
	{ echo 'g/^reload/s/= .*$/= 1/' ; echo w } | ed $statusfile
	stop-wait
}

signal-next () {
	echoerr "switching to next wallpaper"
	echoerr
	(( current += 1 ))
	{ echo 'g/^current/s/= .*$/= '$current'/' ; echo w } | ed $statusfile
	stop-wait
}

signal-stop () {
	echoerr "halting wallpaper"
	echoerr
	stop=0
	write-status-file $statusfile
	stop-wait
	exit 128
}

trap signal-reload SIGUSR1
trap signal-next  SIGUSR2

trap signal-stop    HUP INT TERM

# }}}1

# Initialization {{{1

statusfile=~/racine/run/wall/wallpaper.status
stamp=~/racine/run/wall/wallpaper.stamp

meta=~/racine/list/pictura/wallpaper.meta
logfile=~/log/gen-random-list.log

dispersion=7
minutes=30
seconds=0
current=1
reload=0
stop=0

# }}}1

# Arguments {{{1

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

# }}}1

# Help {{{1

[ $numarg -eq 0 -o $aide -eq 1 ] && {
	echoerr "$(basename $0) : Dynamic wallpaper from random list & priorities."
	echoerr
	echoerr "Dependancies : gen-random-list.zsh, random.zsh"
	echoerr
	echoerr "Usage : $(basename $0) [status-file]"
	echoerr
	echoerr "[Status file format]"
	echoerr
	echoerr "variable = value"
	echoerr
	echoerr "Your status file must at least contain the following variables :"
	echoerr
	echoerr "meta"
	echoerr
	echoerr "Available variables"
	echoerr
	echoerr "dispersion        : the higher it is, the more the list will be shuffled"
	echoerr "minutes & seconds : define delay between wallpaper changes"
	echoerr "meta              : meta-file to generate list"
	echoerr "                    see 'gen-random-list.zsh -h' for details of file format"
	echoerr "current           : index of current wallpaper in list"
	echoerr "reload            : whether to generate a new list"
	echoerr "stop              : whether to save statusfile and stop the script"
	echoerr "statusfile        : path of status file"
	echoerr "stamp             : stamp file, used to know when to reload the status file"
	echoerr "logfile           : log file for gen-random-list.zsh"
	echoerr
	echoerr "[Signals]"
	echoerr
	echoerr "SIGUSR1        : generate a new list and set the first file as wallpaper"
	echoerr "SIGUSR2        : go to the next wallpaper"
	echoerr "HUP, INT, TERM : save status in status file and stop"
	exit 0
}

# }}}1

# Status file {{{1

stamp=${statusfile/.?*/.stamp}
[[ $stamp = $statusfile ]] && stamp=${stamp}.stamp

read-status-file $statusfile

# }}}1

# Empty -> default values {{{1

[ -z $statusfile ] && statusfile=~/racine/run/wall/wallpaper.status
[ -z $stamp ]      && stamp=~/racine/run/wall/wallpaper.stamp

[ -z $meta ]       && meta=~/racine/list/pictura/wallpaper.meta
[ -z $logfile ]    && logfile=~/log/gen-random-list.log

[ -z $dispersion ] && dispersion=0
[ -z $minutes ]    && minutes=0
[ -z $seconds ]    && seconds=0
[ -z $current ]    && current=1
[ -z $reload ]     && reload=0
[ -z $stop ]       && stop=0

[ $minutes -eq 0 -a $seconds -eq 0 ] && {
	minutes=30
	seconds=0
}

(( delay = minutes * 60 + seconds ))

# }}}1

# Image list generation {{{1

liste=${meta/.?*/.m3u}

[ -f $liste ] || {
	gen-random-list.zsh $dispersion $meta &>>! $logfile
}

images=($(cat $liste))
Nimages=${#images}

# }}}1

echo-status-vars

trap 1>&2
echoerr

# {{{ Loop

while true
do
	read-status-file $statusfile
	(( stop > 0 )) && signal-stop
	(( current >= Nimages )) && reload=1
	choose-wallpaper
	regen-image-list $reload
	horodate
	change-wallpaper
	symlink
	write-status-file $statusfile
	await $delay
	# increment
	(( current ++ ))
done

# }}}
