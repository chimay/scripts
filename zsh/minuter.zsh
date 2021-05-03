#! /usr/bin/env zsh

# Minuter

setopt extended_glob

alias notifie='notify-send -t 10000'
alias notifie-long='notify-send -t 30000'

alias psgrep='ps auxww | /bin/grep -v grep | /bin/grep --color=never'

# Valeurs initiales {{{1

hour=0
min=0
sec=0

# }}}1

# Arguments {{{1

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
tableau=(${(s/:/)duration})
hour=$tableau[1]
min=$tableau[2]
sec=$tableau[3]

# }}}1

# Fichier run {{{1

rundir=~/racine/run/minuter

runfile=$rundir/minuteurs

[ -d $rundir ] || mkdir -p $rundir

[ -e $runfile ] || touch $runfile

# }}}1

# ID du minuteur {{{1

identifiants=( ${(f)"$(< $runfile | awk '{print $1}')"} )

mid=1

while true
do
	[[ $identifiants[(i)$mid] -gt $#identifiants ]] && break
	(( mid += 1 ))
done

{
	echo "==============================="
	echo "  $(date +'%H:%M %A %d %B %Y')"
	echo "==============================="
	echo
	echo "Identifiers"
	echo "------------"
	echo
	print -l $identifiants
	echo

	echo "ID of this minuter : $mid"
	echo
} >>! ~/log/minuteur-$mid.log

# }}}1

{
	echo Canonical format : $hour:$min:$sec
	echo
} >>! ~/log/minuteur-$mid.log

# }}}1

# Total de sec {{{1

(( total = hour * 3600 + min * 60 + sec ))

# }}}1

# Traps {{{1

# Pour ajouter une fonction liée au signal :
#
# trap fonction SIGNAL
#
# Pour effacer les fonctions liées au signal :
#
# trap - SIGNAL

clausule () {

	{
		echo
		echo
		echo "Stopping ..."
		echo
		echo "sed -i '/^'$mid'/d' $runfile"
		echo
	} >>! ~/log/minuteur-$mid.log

	sed -i '/^'$mid'/d' $runfile

	exit 128
}

trap clausule HUP INT TERM

{
	echo "Traps"
	echo "-----"
	echo

	trap

	echo
} >>! ~/log/minuteur-$mid.log

# }}}1

# Informations HH:MM:SS {{{1

{
	echo "HH:MM:SS"
	echo "--------"
	echo
} >>! ~/log/minuteur-$mid.log

if (( hour > 0 && min > 0 && sec > 0 ))
then
	chaine_echo="$hour hour $min min $sec sec =  $total sec"
	chaine_notification="Minuter : $hour hou $min min $sec sec"
elif (( hour > 0 && min > 0 && sec == 0 ))
then
	chaine_echo="$hour hour $min min =  $total sec"
	chaine_notification="Minuter : $hour hou $min min"
elif (( hour > 0 && min == 0 && sec > 0 ))
then
	chaine_echo="$hour hour $sec sec =  $total sec"
	chaine_notification="Minuter : $hour hou $sec sec"
elif (( hour > 0 && min == 0 && sec == 0 ))
then
	chaine_echo="$hour hour =  $total sec"
	chaine_notification="Minuter : $hour hou"
elif (( hour == 0 && min > 0 && sec > 0 ))
then
	chaine_echo="$min min $sec sec =  $total sec"
	chaine_notification="Minuter : $min min $sec sec"
elif (( hour == 0 && min > 0 && sec == 0 ))
then
	chaine_echo="$min min =  $total sec"
	chaine_notification="Minuter : $min min"
elif (( hour == 0 && min == 0 && sec > 0 ))
then
	chaine_echo="$sec sec =  $total sec"
	chaine_notification="Minuter : $sec sec"
else
	chaine_echo="Instant minuter"
	chaine_notification="Instant minuter"
fi

{
	echo $chaine_echo
	echo
} >>! ~/log/minuteur-$mid.log

notifie $chaine_notification &

chaine_runfile="$mid : $chaine_echo"

{
	echo $chaine_runfile >>! $runfile
} >>! ~/log/minuteur-$mid.log

# }}}1

# Minuteurs {{{1

minuteurs=( ${(f)"$(< $runfile)"} )

{
	echo "Minuteurs"
	echo "---------"
	echo
	print -l $minuteurs
	echo
} >>! ~/log/minuteur-$mid.log

# }}}1

# Journal début {{{1

{
	echo -n " $mid DÉBUT $(date +'%a %d %b %Y %H:%M:%S') : "
	echo "$hour heu $min min $sec sec"

} >>! ~/log/minuter.log

# }}}1

# minuter {{{1

sleep $total

{
	echo "sonnerie.zsh $=arguments"
	echo
} >>! ~/log/minuteur-$mid.log

sonnerie.zsh $=arguments

notifie-long "$chaine_notification a sonné !" &

# }}}1

# Journal fin {{{1

{
	echo -n " $mid ----- $(date +'%a %d %b %Y %H:%M:%S') : "
	echo "$hour heu $min min $sec sec"

} >>! ~/log/minuter.log

# }}}1

# Suppression du minuteur dans $runfile {{{1

sed -i '/^'$mid'/d' $runfile

# }}}1

# Vérification des lignes abondonnées dans $runfile {{{1

processi=("${(f)$(psgrep minuter.zsh)}")

{
	echo "Processi"
	echo "--------"
	echo
	print -l $processi
	echo
} >>! ~/log/minuteur-$mid.log

# On enlève 1 pour le processus $(...)

numproc=$(( $#processi - 1 ))

{
	echo "Nombre de minuteries en route : $numproc"
	echo
} >>! ~/log/minuteur-$mid.log

# On enlève les lignes abandonnées

(( numproc <= 1 )) && {

	{
		echo "Runfile"
		echo "-------"
		echo
		cat $runfile
		echo
	} >>! ~/log/minuteur-$mid.log

	abandonnees=$(wc -l $runfile | awk '{print $1}')

	{
		echo "Nombre de lignes abandonnées : " $abandonnees
		echo
	} >>! ~/log/minuteur-$mid.log

	(( $abandonnees > 0 )) && {

		{
			echo "{ echo '1,\$d' ; echo w } | ed $runfile"
			echo
		} >>! ~/log/minuteur-$mid.log

		{ echo '1,$d' ; echo w } | ed $runfile
	}
}

# }}}1

exit 0
