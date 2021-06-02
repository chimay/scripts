#! /usr/bin/env zsh

# vim: fdm=indent:

# Minuter

setopt extended_glob

alias notifie='notify-send -t 10000'
alias notifie-long='notify-send -t 30000'
alias psgrep='ps auxww | /bin/grep -v grep | /bin/grep --color=never'

# Initial values

hours=0
minutes=0
seconds=0

# Arguments

arguments=()

while true
do
	case $1 in
		[0-9./:]##)
			tempus=$1
			shift
			;;
		?*)
			arguments+=$1
			shift
			;;
		*)
			break
	esac
done

duration=$(canonical-duration.zsh $tempus)
duratab=(${(s/:/)duration})
hours=$duratab[1]
minutes=$duratab[2]
seconds=$duratab[3]

# Run file

rundir=~/racine/run/minuter
runfile=$rundir/minuters
[ -d $rundir ] || mkdir -p $rundir
[ -e $runfile ] || touch $runfile

# ID of this minuter

identifiers=( ${(f)"$(< $runfile | awk '{print $1}')"} )
iden=1
while true
do
	[[ $identifiers[(i)$iden] -gt $#identifiers ]] && break
	(( iden += 1 ))
done

# Log file

logdir=~/log
commonlog=$logdir/minuters.log
logfile=$logdir/minuter-$iden.log
[ -d $logdir ] || mkdir -p $logdir
[ -e $logfile ] || touch $logfile

# Traps

# Add a function to SIGNAL :
#
# trap fonction SIGNAL
#
# Remove all functions linked to SIGNAL :
#
# trap - SIGNAL

clausule () {
	{
		echo
		echo
		echo "Stopping ..."
		echo
		echo "sed -i '/^'$iden'/d' $runfile"
		echo
	} >>! $logfile
	sed -i '/^'$iden'/d' $runfile
	exit 128
}

trap clausule HUP INT TERM

{
	echo "Traps"
	echo "-----"
	echo
	trap
	echo
} >>! $logfile

# Log basic infos

{
	echo "==============================="
	echo "  $(date +'%H:%M %A %d %B %Y')"
	echo "==============================="
	echo
	echo "Identifiers"
	echo "------------"
	echo
	print -l $identifiers
	echo
	echo "ID of this minuter : $iden"
	echo
	echo Canonical format : $duration
	echo
} >>! $logfile

# Total time in seconds

(( total = hours * 3600 + minutes * 60 + seconds ))

# Long time format

{
	echo "HH:MM:SS"
	echo "--------"
	echo
} >>! $logfile

if (( hours > 0 && minutes > 0 && seconds > 0 ))
then
	echome="$hours hours $minutes minutes $seconds seconds =  $total seconds"
	notify_msg="Minuter : $hours hou $minutes minutes $seconds seconds"
elif (( hours > 0 && minutes > 0 && seconds == 0 ))
then
	echome="$hours hours $minutes minutes =  $total seconds"
	notify_msg="Minuter : $hours hou $minutes minutes"
elif (( hours > 0 && minutes == 0 && seconds > 0 ))
then
	echome="$hours hours $seconds seconds =  $total seconds"
	notify_msg="Minuter : $hours hou $seconds seconds"
elif (( hours > 0 && minutes == 0 && seconds == 0 ))
then
	echome="$hours hours =  $total seconds"
	notify_msg="Minuter : $hours hou"
elif (( hours == 0 && minutes > 0 && seconds > 0 ))
then
	echome="$minutes minutes $seconds seconds =  $total seconds"
	notify_msg="Minuter : $minutes minutes $seconds seconds"
elif (( hours == 0 && minutes > 0 && seconds == 0 ))
then
	echome="$minutes minutes =  $total seconds"
	notify_msg="Minuter : $minutes minutes"
elif (( hours == 0 && minutes == 0 && seconds > 0 ))
then
	echome="$seconds seconds =  $total seconds"
	notify_msg="Minuter : $seconds seconds"
else
	echome="Instant minuter"
	notify_msg="Instant minuter"
fi

{
	echo $echome
	echo
} >>! $logfile

# Record this minuter in runfile

runline="$iden : $echome"
echo $runline >>! $runfile

# Minuters in log file

minuters=( ${(f)"$(< $runfile)"} )

{
	echo "minuters"
	echo "---------"
	echo
	print -l $minuters
	echo
} >>! $logfile

# Notify begin

notifie $notify_msg &

# Common log begin

{
	echo -n " $iden BEGIN $(date +'%a %d %b %Y %H:%M:%S') : "
	echo "$hours hours $minutes minutes $seconds seconds"

} >>! $commonlog

# Counting zzz

sleep $total

# Ring

{
	echo "bell.zsh $=arguments"
	echo
} >>! $logfile

bell.zsh $=arguments

# Notify end

notifie-long "$notify_msg a sonné !" &

# Common log end

{
	echo -n " $iden ----- $(date +'%a %d %b %Y %H:%M:%S') : "
	echo "$hours heu $minutes minutes $seconds seconds"

} >>! $commonlog

# Delete this minuter in $runfile

sed -i '/^'$iden'/d' $runfile

# Check abandoned lines in $runfile

processi=("${(f)$(psgrep minuter.zsh)}")

{
	echo "Processi"
	echo "--------"
	echo
	print -l $processi
	echo
} >>! $logfile

# Minus 1 for the processus $(...)

numproc=$(( $#processi - 1 ))

{
	echo "Number of running minuters : $numproc"
	echo
} >>! $logfile

# Remove abandoned lines

(( numproc <= 1 )) && {
	{
		echo "Runfile"
		echo "-------"
		echo
		cat $runfile
		echo
	} >>! $logfile
	abandoned=$(wc -l $runfile | awk '{print $1}')
	{
		echo "Nombre de lignes abandonnées : " $abandoned
		echo
	} >>! $logfile
	(( $abandoned > 0 )) && {
		{
			echo "{ echo '1,\$d' ; echo w } | ed $runfile"
			echo
		} >>! $logfile
		{ echo '1,$d' ; echo w } | ed $runfile
	}
}

exit 0
