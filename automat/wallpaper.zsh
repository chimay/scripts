#! /usr/bin/env zsh

# options {{{1

setopt null_glob
setopt extended_glob

# functions {{{1

# echoerr {{{2

echoerr () {
	print "$@" >&2
}

# help {{{2

help () {
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
	echoerr "Available variables"
	echoerr
	echoerr "meta              : meta-file to generate list"
	echoerr "                    see 'gen-random-list.zsh -h' for details of file format"
	echoerr "logfile           : log file for gen-random-list.zsh"
	echoerr "dispersion        : the higher it is, the more the list will be shuffled"
	echoerr "minutes & seconds : define delay between wallpaper changes"
	echoerr "current           : index of current wallpaper in list"
	echoerr "reload            : whether to generate a new list"
	echoerr "stop              : whether to save statusfile and stop the script"
	echoerr
	echoerr "[Signals]"
	echoerr
	echoerr "SIGUSR1        : generate a new list and set the first file as wallpaper"
	echoerr "SIGUSR2        : go to the next wallpaper"
	echoerr "HUP, INT, TERM : save status in status file and stop"
	exit 0
}

# stop-wait {{{2

stop-wait () {
	echo "stop waiting"
	echo
	[ -z $waitpid ] || kill $waitpid
	waitpid=
}

# init-empty-vars {{{2

init-empty-vars () {
	[ -z $statusfile ] && statusfile=~/racine/run/wall/wallpaper.status
	[ -z $stamp ]      && stamp=~/racine/run/wall/wallpaper.stamp
	[ -z $meta ]       && meta=~/racine/index/pictura/wallpaper.meta
	[ -z $logfile ]    && logfile=~/log/gen-random-list.log
	[ -z $dispersion ] && dispersion=7
	[ -z $minutes ]    && minutes=30
	[ -z $seconds ]    && seconds=0
	[ -z $current ]    && current=1
	[ -z $reload ]     && reload=0
	[ -z $stop ]       && stop=0
	if [ $minutes -eq 0 -a $seconds -eq 0 ]
	then
		minutes=30
		seconds=0
	fi
	(( delay = minutes * 60 + seconds ))
}

# echo-status-vars {{{2

echo-status-vars () {
	echo statusfile  : $statusfile
	echo meta        : $meta
	echo logfile     : $logfile
	echo dispersion  : $dispersion
	echo minutes     : $minutes
	echo seconds     : $seconds
	echo delay       : $delay
	echo current     : $current
	echo reload      : $reload
	echo stop        : $stop
	echo
}

# write-status-file {{{2

write-status-file () {
	local statusfile=$1
	local stamp=$2
	echo "writing status file"
	echo
	cat <<- fin >| $statusfile
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

# update-current-in-status-file {{{2

update-current-in-status-file () {
	echo "updating current in status file"
	echo
	{ echo 'g/^current/s/= .*$/= '$current'/' ; echo w } | ed $statusfile &> ~/log/ed.log
}

# update-reload-in-status-file {{{2

update-reload-in-status-file () {
	echo "updating reload in status file"
	echo
	{ echo 'g/^reload/s/= .*$/= '$reload'/' ; echo w } | ed $statusfile &> ~/log/ed.log
}

# read-status-file {{{2

read-status-file () {
	local statusfile=$1
	local stamp=$2
	[[ $statusfile -nt $stamp ]] || return 0
	echo "reading status file"
	echo
	touch $stamp
	while read ligne
	do
		ligne=${ligne// }
		eval $ligne
	done < $statusfile
	(( delay = minutes * 60 + seconds ))
	echo-status-vars
}

# choose-wallpaper {{{2

choose-wallpaper () {
	while [ ! -e $images[$current] -a $current -lt $Nimages ]
	do
		echo choose-wallpaper : file $images[$current] does not exist, skipping
		echo
		echo choose-wallpaper : incremeting current
		(( current ++ ))
	done
	if (( current < Nimages ))
	then
		poster=$images[$current]
	else
		echo "choose-wallpaper : reload -> 1"
		echo
		reload=1
	fi
}

# gen-image-list {{{2

gen-image-list () {
	local reload=$1
	random_list=${meta/.?*/.m3u}
	if [ ! -f $random_list ]
	then
		echo "gen-image-list : wallpaper list does not exist"
		echo
	fi
	if [ $reload -eq 1 -o ! -f $random_list ]
	then
		echo "gen-image-list : generating new wallpaper list"
		echo
		gen-random-list.zsh $dispersion $meta &>>! $logfile
		images=($(< $random_list))
		current=1
		Nimages=${#images}
		poster=$images[$current]
		update-current-in-status-file
		echo-status-vars
	fi
	if [ -z $Nimages ]
	then
		echo "gen-image-list : assigning image list"
		echo
		images=($(< $random_list))
		Nimages=${#images}
		poster=$images[$current]
	fi
	if [ $reload -eq 1 ]
	then
		echo "gen-image-list : resetting reload to 0"
		echo
		reload=0
		update-reload-in-status-file
	fi
}

# horodate {{{2

horodate () {
	date_hour=`date +"%a %d %b %Y, %H:%M"`
	echo $date_hour : $current : $poster
	echo
}

# change-wallpaper {{{2

change-wallpaper () {
	feh --bg-max --no-fehbg $poster
}

# symlink {{{2

symlink () {
	# Pour i3lock
	link=${statusfile%/*}/current
	[ -L $link ] && {
		#echo "rm -f $link"
		#echo
		rm -f $link
	}
	ln -s $poster $link
}

# await {{{2

await () {
	local delay=$1
	echo "waiting $delay seconds"
	echo
	# so as not to delay traps interception
	sleep $delay &
	waitpid=$!
	wait $waitpid
}

# increment {{{2

increment () {
	echo incrementing current
	echo
	(( current ++ ))
}

# traps {{{1

signal-next () {
	echo "switching to next wallpaper"
	echo
	echo signal-next : incrementing current
	echo
	(( current ++ ))
	update-current-in-status-file
	stop-wait
}

signal-reload () {
	date_hour=`date +"%a %d %b %Y, %H:%M"`
	echo "$date_hour : reloading wallpapers list"
	echo
	reload=1
	update-reload-in-status-file
	stop-wait
}

signal-stop () {
	echo "halting wallpaper"
	echo
	stop=0
	write-status-file $statusfile $stamp
	stop-wait
	exit 128
}

trap signal-reload SIGUSR1
trap signal-next  SIGUSR2

trap signal-stop    HUP INT TERM

# arguments {{{1

statusfile=

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

# initialization {{{1

[ $numarg -eq 0 -o $aide -eq 1 ] && help

echo
echo '================================================================================'
date +"   wallpaper starting %A %d %B %Y  (o) %H : %M : %S  | %:z | "
echo '================================================================================'
echo
echo statusfile : $statusfile
echo stamp : $stamp
echo

read-status-file $statusfile $stamp

init-empty-vars

gen-image-list $reload

trap 1>&2
echo

echo "wallpaper is launched"
echo

# status file {{{1

stamp=${statusfile/.?*/.stamp}

[[ $statusfile = $stamp ]] && stamp=${stamp}.stamp

touch $statusfile

# loop {{{1

while true
do
	read-status-file $statusfile $stamp
	(( stop > 0 )) && signal-stop
	choose-wallpaper
	gen-image-list $reload
	horodate
	change-wallpaper
	symlink
	await $delay
	increment
done

# }}}
