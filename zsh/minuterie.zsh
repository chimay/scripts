#! /usr/bin/env zsh

setopt extended_glob

alias notifie='notify-send -t 10000'
alias notifie-long='notify-send -t 30000'

alias psgrep='ps auxww | /bin/grep -v grep | /bin/grep --color=never'

# Valeurs initiales {{{1

heures=0
minutes=0
secondes=0

# }}}1

# Arguments {{{1

arguments=()

while true
do
	case $1 in

		[0-9]##)
			minutes=$1
			shift
			;;
		[0-9]##:[0-9]##)
			minutes=${1%:*}
			secondes=${1#*:}
			shift
			;;
		[0-9]##:[0-9]##:[0-9]##)
			temps=(${(s/:/)1})
			heures=$temps[1]
			minutes=$temps[2]
			secondes=$temps[3]
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

# }}}1

# Total {{{1

total=$(expr $heures '*' 3600 + $minutes '*' 60 + $secondes)

# }}}1

# Fichier run {{{1

rundir=~/racine/run/minuter

runfile=$rundir/minuteurs

[ -d $rundir ] || mkdir -p $rundir

[ -e $runfile ] || touch $runfile

minuteurs=( ${(f)"$(< $runfile)"} )

# }}}1

# ID du minuteur {{{1

identifiants=( ${(f)"$(< $runfile | awk '{print $1}')"} )

echo "Identifiants"
echo "------------"
echo
print -l $identifiants
echo

mid=1

while true
do
	[[ $identifiants[(i)$mid] -gt $#identifiants ]] && break
	(( mid += 1 ))
done

echo "ID de ce minuteur : $mid"
echo

# }}}1

# Trap Ctrl-C interruption {{{1

TRAPINT () {

	sed -i '/^'$mid'/d' $runfile

	exit 128
}

# }}}1

# Informations HH:MM:SS {{{1

if (( heures > 0 && minutes > 0 && secondes > 0 ))
then
	chaine_echo="$heures heures $minutes minutes $secondes secondes =  $total secondes"

	chaine_notification="Minuterie : $heures heu $minutes min $secondes sec"

elif (( heures > 0 && minutes > 0 && secondes == 0 ))
then
	chaine_echo="$heures heures $minutes minutes =  $total secondes"

	chaine_notification="Minuterie : $heures heu $minutes min"

elif (( heures > 0 && minutes == 0 && secondes > 0 ))
then
	chaine_echo="$heures heures $secondes secondes =  $total secondes"

	chaine_notification="Minuterie : $heures heu $secondes sec"

elif (( heures > 0 && minutes == 0 && secondes == 0 ))
then
	chaine_echo="$heures heures =  $total secondes"

	chaine_notification="Minuterie : $heures heu"

elif (( heures == 0 && minutes > 0 && secondes > 0 ))
then
	chaine_echo="$minutes minutes $secondes secondes =  $total secondes"

	chaine_notification="Minuterie : $minutes min $secondes sec"

elif (( heures == 0 && minutes > 0 && secondes == 0 ))
then
	chaine_echo="$minutes minutes =  $total secondes"

	chaine_notification="Minuterie : $minutes min"

elif (( heures == 0 && minutes == 0 && secondes > 0 ))
then
	chaine_echo="$secondes secondes =  $total secondes"

	chaine_notification="Minuterie : $secondes sec"

else
	chaine_echo="Minuterie instantanée"

	chaine_notification="Minuterie instantanée"
fi

chaine_runfile="$mid : $chaine_echo"

echo $chaine_echo
echo

echo $chaine_runfile >>! $runfile

notifie $chaine_notification &

minuteurs+=$chaine_runfile

echo "Minuteurs"
echo "---------"
echo
print -l $minuteurs
echo

# }}}1

# Journal début {{{1

{
	echo -n " $mid DÉBUT $(date +'%a %d %b %Y %H:%M:%S') : "
	echo "$heures heu $minutes min $secondes sec"

} >>! ~/log/minuterie.log

# }}}1

# Minuterie {{{1

sleep $total

echo "sonnerie.zsh $=arguments"
echo

sonnerie.zsh $=arguments

notifie-long "La minuterie a sonné !" &

# }}}1

# Journal fin {{{1

{
	echo -n " $mid ----- $(date +'%a %d %b %Y %H:%M:%S') : "
	echo "$heures heu $minutes min $secondes sec"

} >>! ~/log/minuterie.log

# }}}1

# Suppression du minuteur dans $runfile {{{1

sed -i '/^'$mid'/d' $runfile

# }}}1
