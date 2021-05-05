#! /usr/bin/env zsh

# vim: fdm=indent:

# REPL for multi infusions

# REPL : Read Eval Print Loop
#
# Ctrl-D ou Ctrl-C pour interrompre la boucle

setopt extended_glob

TRAPINT () {
	echo
	echo
	echo "Stopping ..."
	echo
	exit 128
}

# Functions

duration-prompt () {
	if (( hour > 0 && min > 0 && sec > 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> timer duration ? [$hour hour $min min $sec sec] "
	elif (( hour > 0 && min > 0 && sec == 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> timer duration ? [$hour hour $min min] "
	elif (( hour > 0 && min == 0 && sec > 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> timer duration ? [$hour hour $sec sec] "
	elif (( hour > 0 && min == 0 && sec == 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> timer duration ? [$hour hour] "
	elif (( hour == 0 && min > 0 && sec > 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> timer duration ? [$min min $sec sec] "
	elif (( hour == 0 && min > 0 && sec == 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> timer duration ? [$min min] "
	elif (( hour == 0 && min == 0 && sec > 0 ))
	then
		echo
		echo -n " <$(date +%H:%M)> timer duration ? [$sec sec] "
	else
		echo
		echo -n " <$(date +%H:%M)> timer duration ? [$min min] "
	fi
}

# Initialisation

duration=0:1:0

augment=0

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
			augment=$tableau[2]
			shift
			;;
		*)
			break
			;;
	esac
done

duration=$(canonical-duration.zsh $tempus)
tableau=(${(s/:/)duration})
hour=$tableau[1]
min=$tableau[2]
sec=$tableau[3]

if [ $augment -gt 0 ]
then
	echo Default duration will be increased by $augment seconds each time.
fi

duration-prompt

while read tempus
do
	if [ $#tempus -eq 0 ]
	then
		tempus=$hour:$min:$sec
	fi
	duration=$(canonical-duration.zsh $tempus)
	tableau=(${(s/:/)duration})
	hour=$tableau[1]
	min=$tableau[2]
	sec=$tableau[3]

	if (( hour > 0 && min > 0 && sec > 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong in $hour hour $min min $sec sec"
	elif (( hour > 0 && min > 0 && sec == 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong in $hour hour $min min"
	elif (( hour > 0 && min == 0 && sec > 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong in $hour hour $sec sec"
	elif (( hour > 0 && min == 0 && sec == 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong in $hour hour"
	elif (( hour == 0 && min > 0 && sec > 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong in $min min $sec sec"
	elif (( hour == 0 && min > 0 && sec == 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong in $min min"
	elif (( hour == 0 && min == 0 && sec > 0 ))
	then
		echo
		echo "	[$(date +%H:%M)] Ding dong in $sec sec"
	else
		echo
		echo "	[$(date +%H:%M)] Ding dong now"
	fi

	default-minuter.zsh $hour:$min:$sec &> /dev/null

	(( sec += augment ))

	duration=$(canonical-duration.zsh $hour:$min:$sec)
	tableau=(${(s/:/)duration})
	hour=$tableau[1]
	min=$tableau[2]
	sec=$tableau[3]

	duration-prompt
done
