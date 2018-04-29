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

total=$(expr $heures '*' 3600 + $minutes '*' 60 + $secondes)

# Fichier témoin {{{1

rundir=~/racine/run/minuter

[ -d $rundir ] || mkdir -p $rundir

fichiers=( $(print -l $rundir/temoin-*) )

mid=$(( $#fichiers + 1 ))

celuici=$rundir/temoin-$mid

echo "touch $celuici"
echo

touch $celuici

# }}}1

# Trap Ctrl-C interruption {{{1

TRAPINT () {

	echo "rm -f $celuici"
	echo

	rm -f $celuici

	exit 128
}

# }}}1

# Informations {{{1

if (( heures > 0 && minutes > 0 && secondes > 0 ))
then
	echo "$heures heures $minutes minutes $secondes secondes =  $total secondes"
	echo

	echo "$heures heures $minutes minutes $secondes secondes =  $total secondes" >! ~celuici

	notifie "Minuterie : $heures heu $minutes min $secondes sec" &

elif (( heures > 0 && minutes > 0 && secondes == 0 ))
then
	echo "$heures heures $minutes minutes =  $total secondes"
	echo

	echo "$heures heures $minutes minutes =  $total secondes" >! ~celuici

	notifie "Minuterie : $heures heu $minutes min" &

elif (( heures > 0 && minutes == 0 && secondes > 0 ))
then
	echo "$heures heures $secondes secondes =  $total secondes"
	echo

	echo "$heures heures $secondes secondes =  $total secondes" >! ~celuici

	notifie "Minuterie : $heures heu $secondes sec" &

elif (( heures > 0 && minutes == 0 && secondes == 0 ))
then
	echo "$heures heures =  $total secondes"
	echo

	echo "$heures heures =  $total secondes" >! ~celuici

	notifie "Minuterie : $heures heu" &

elif (( heures == 0 && minutes > 0 && secondes > 0 ))
then
	echo "$minutes minutes $secondes secondes =  $total secondes"
	echo

	echo "$minutes minutes $secondes secondes =  $total secondes" >! ~celuici

	notifie "Minuterie : $minutes min $secondes sec" &

elif (( heures == 0 && minutes > 0 && secondes == 0 ))
then
	echo "$minutes minutes =  $total secondes"
	echo

	echo "$minutes minutes =  $total secondes" >! ~celuici

	notifie "Minuterie : $minutes min" &

elif (( heures == 0 && minutes == 0 && secondes > 0 ))
then
	echo "$secondes secondes =  $total secondes"
	echo

	echo "$secondes secondes =  $total secondes" >! ~celuici

	notifie "Minuterie : $secondes sec" &

else
	echo "Minuterie instantanée"
	echo

	echo "Minuterie instantanée" >! ~celuici

	notifie "Minuterie instantanée" &
fi

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

# Suppression du fichier témoin {{{1

echo "rm -f $celuici"
echo

rm -f $celuici

# }}}1

# Vérification des fichiers témoins abondonnés {{{1

processus=("${(f)$(psgrep minuterie.zsh)}")

# On enlève 1 pour le processus $(...)

nombre=$(( $#processus - 1 ))

echo "Nombre de minuteries en route : $nombre"
echo

# On enlève les fichiers témoins abandonnés

(( nombre <= 1 )) && {

	abandonnes=($rundir/*)

	(( $#abandonnes > 0 )) && {

		echo "rm -f $abandonnes"
		echo

		# Normalement plus nécessaire, grâce au TRAPINT

		#rm -f $abandonnes
	}
}

exit 0

# }}}1
