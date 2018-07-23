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
	echo "Identifiants"
	echo "------------"
	echo
	print -l $identifiants
	echo

	echo "ID de ce minuteur : $mid"
	echo
} >>! ~/log/minuteur-$mid.log

# }}}1

# Format canonique {{{1

{
	echo Format en argument : $heures:$minutes:$secondes
	echo
} >>! ~/log/minuteur-$mid.log

integer quotient modulo

# N x 60 secondes -> N minutes

(( quotient = secondes / 60 ))
(( modulo = secondes % 60 ))

(( minutes += quotient ))
(( secondes = modulo ))

# N x 60 minutes -> N heures

(( quotient = minutes / 60 ))
(( modulo = minutes % 60 ))

(( heures += quotient ))
(( minutes = modulo ))

{
	echo Format canonique : $heures:$minutes:$secondes
	echo
} >>! ~/log/minuteur-$mid.log

# }}}1

# Total de secondes {{{1

total=$(expr $heures '*' 3600 + $minutes '*' 60 + $secondes)

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
		echo "On arrête ..."
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
	echo "$heures heu $minutes min $secondes sec"

} >>! ~/log/minuterie.log

# }}}1

# Minuterie {{{1

sleep $total

{
	echo "sonnerie.zsh $=arguments"
	echo
} >>! ~/log/minuteur-$mid.log

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

# Vérification des lignes abondonnées dans $runfile {{{1

processi=("${(f)$(psgrep minuterie.zsh)}")

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
