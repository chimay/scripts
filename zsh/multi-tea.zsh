#! /usr/bin/env zsh

# vim: fdm=indent:

# REPL for multi infusions

# REPL : Read Eval Print Loop
#
# Ctrl-D ou Ctrl-C pour interrompre la boucle

setopt extended_glob

# Help

[ $# -gt 0 ] && [ $1 = -h -o $1 = --help -o $1 = help ] && {
	echo "Usage : `basename $0` [default-time [+increment-time] ]"
	exit 0
}

# Signals

TRAPINT () {
	echo
	echo
	echo "Stopping ..."
	echo
	exit 128
}

# Functions

duration-prompt () {
	local hours=$1
	local minutes=$2
	local seconds=$3
	if (( hours > 0 && minutes > 0 && seconds > 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> timer duration ? [$hours hours $minutes minutes $seconds seconds] "
	elif (( hours > 0 && minutes > 0 && seconds == 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> timer duration ? [$hours hours $minutes minutes] "
	elif (( hours > 0 && minutes == 0 && seconds > 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> timer duration ? [$hours hours $seconds seconds] "
	elif (( hours > 0 && minutes == 0 && seconds == 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> timer duration ? [$hours hours] "
	elif (( hours == 0 && minutes > 0 && seconds > 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> timer duration ? [$minutes minutes $seconds seconds] "
	elif (( hours == 0 && minutes > 0 && seconds == 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> timer duration ? [$minutes minutes] "
	elif (( hours == 0 && minutes == 0 && seconds > 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> timer duration ? [$seconds seconds] "
	else
		echo
		echo -n " <$(date +%H:%M)> timer duration ? [$minutes minutes] "
	fi
}

minuter-info () {
	local hours=$1
	local minutes=$2
	local seconds=$3
	if (( hours > 0 && minutes > 0 && seconds > 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong in $hours hours $minutes minutes $seconds seconds"
	elif (( hours > 0 && minutes > 0 && seconds == 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong in $hours hours $minutes minutes"
	elif (( hours > 0 && minutes == 0 && seconds > 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong in $hours hours $seconds seconds"
	elif (( hours > 0 && minutes == 0 && seconds == 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong in $hours hours"
	elif (( hours == 0 && minutes > 0 && seconds > 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong in $minutes minutes $seconds seconds"
	elif (( hours == 0 && minutes > 0 && seconds == 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong in $minutes minutes"
	elif (( hours == 0 && minutes == 0 && seconds > 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong in $seconds seconds"
	else
		echo
		echo "	[$(date +%H:%M)] Ding dong now"
	fi
}

# Initialisation

tempus=0:1:0
increment=0:0:0

# Arguments

while true
do
	case $1 in
		[0-9./:]##)
			tempus=$1
			shift
			;;
		[0-9./:+]##)
			tableau=(${(s/+/)1})
			tempus=$tableau[1]
			increment=$tableau[2]
			shift
			;;
		*)
			break
			;;
	esac
done

duration=$(canonical-duration.zsh $tempus)
duratab=(${(s/:/)duration})
hours=$duratab[1]
minutes=$duratab[2]
seconds=$duratab[3]

augment=$(canonical-duration.zsh $increment)
augmentab=(${(s/:/)augment})
added_hours=$augmentab[1]
added_minutes=$augmentab[2]
added_seconds=$augmentab[3]

if [ $augment != 0:0:0 ]
then
	echo Default duration will be increased by $augment each time.
fi

duration-prompt $hours $minutes $seconds

while read tempus
do
	if [ $#tempus -eq 0 ]
	then
		tempus=$hours:$minutes:$seconds
	elif [ $tempus = q -o $tempus = quit ]
	then
		# q to quit
		break
	fi
	duration=$(canonical-duration.zsh $tempus)
	duratab=(${(s/:/)duration})
	hours=$duratab[1]
	minutes=$duratab[2]
	seconds=$duratab[3]
	# launch minuter
	minuter-info $hours $minutes $seconds
	ding-dong.zsh $hours:$minutes:$seconds &> /dev/null
	# add increment for next minuter
	(( hours += added_hours ))
	(( minutes += added_minutes ))
	(( seconds += added_seconds ))
	duration=$(canonical-duration.zsh $hours:$minutes:$seconds)
	duratab=(${(s/:/)duration})
	hours=$duratab[1]
	minutes=$duratab[2]
	seconds=$duratab[3]
	# prompt
	duration-prompt $hours $minutes $seconds
done
