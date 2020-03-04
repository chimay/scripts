#! /usr/bin/env zsh

# {{{ Options de zsh

setopt null_glob
setopt extended_glob

# }}}

# Fonctions {{{1

echoerr () {
	print "$@" >&2
}

signal-reload () {
	echoerr
	echoerr "reload -> 1"
	echoerr
	reload=1
}

signal-next () {
	echoerr
	echoerr "next -> 1"
	echoerr
	[ -z $attendre ] || kill $attendre
}

signal-stop () {
	echoerr "stop -> 1"
	echoerr
	echoerr "On arrête wallpaper"
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

trap signal-reload SIGUSR1
trap signal-next  SIGUSR2

trap signal-stop    HUP INT TERM

# }}}1

# Initialisation {{{1

statusfile=~/racine/run/wall/wallpaper.status

# }}}1

# Arguments {{{1

numarg=$#

aide=0

while true
do
	case $1 in
		-h)
			aide=1
			shift
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

# Aide {{{1

[ $numarg -eq 0 -o $aide -eq 1 ] && {
	echo "$(basename $0) : Dynamic wallpaper from random list & priorities."
	echo
	echo "Dependancies : gen-random-list.zsh, random.zsh"
	echo
	echo "Usage : $(basename $0) status-file"
	echo
	echo "[Status file format]"
	echo
	echo "variable = value"
	echo
	echo "Your status file must at least contain the following variables :"
	echo
	echo "meta"
	echo
	echo "Available variables"
	echo
	echo "dispersion        : the higher it is, the more the list will be shuffled"
	echo "minutes & seconds : define time between wallpaper changes"
	echo "meta              : meta-file to generate list"
	echo "                    see 'gen-random-list.zsh -h' for details of file format"
	echo "current           : index of current wallpaper in list"
	echo "reload            : whether to generate a new list"
	echo "stop              : whether to save statusfile and stop the script"
	echo "statusfile        : path of status file"
	echo "stamp             : stamp file, used to know when to reload the status file"
	echo "logfile           : log file for gen-random-list.zsh"
	exit 0
}

# }}}1

# Lecture préliminaire du fichier état {{{1

stamp=${statusfile/.?*/.stamp}
[[ $statusfile = $stamp ]] && stamp=${stamp}.stamp

if [ -f $statusfile ]
then
	touch $stamp

	while read ligne
	do
		ligne=${ligne// }
		eval $ligne
	done < $statusfile

	(( temps = minutes * 60 + seconds ))

	echoerr
	echoerr "*** Lecture préliminaire du fichier état ***"
	echoerr
	echoerr Dispersion  : $dispersion
	echoerr Minutes     : $minutes
	echoerr Seconds     : $seconds
	echoerr Time        : $temps
	echoerr Meta        : $meta
	echoerr Current     : $current
	echoerr Reload      : $reload
	echoerr Stop        : $stop
	echoerr Status file : $statusfile
	echoerr Stamp file  : $stamp
	echoerr Log file    : $logfile
	echoerr
else
	echoerr "Status file has to exist to continue."
	echoerr
	exit 1
fi

# }}}1

# Valeurs par défaut {{{1

[ -z $dispersion ] && dispersion=0
[ -z $minutes ]    && minutes=0
[ -z $seconds ]    && seconds=0
[ -z $current ]    && current=1
[ -z $reload ]     && reload=0
[ -z $stop ]       && stop=0
[ -z $logfile ]    && logfile=~/log/gen-random-list.log

[ $minutes -eq 0 -a $seconds -eq 0 ] && {
	minutes=30
	seconds=0
}

(( temps = minutes * 60 + seconds ))

# }}}1

# Génération de la liste {{{1

liste=${meta/.?*/.m3u}

[ -f $liste ] || {
	gen-random-list.zsh $dispersion $meta &>>! $logfile
}

# }}}1

# Images {{{1

images=($(cat $liste))

Nimages=${#images}

# }}}1

# Affichage {{{1

echoerr "*** Affichage avant la boucle ***"
echoerr
echoerr Dispersion  : $dispersion
echoerr Minutes     : $minutes
echoerr Seconds     : $seconds
echoerr Time        : $temps
echoerr Meta        : $meta
echoerr Current     : $current
echoerr Reload      : $reload
echoerr Stop        : $stop
echoerr Status file : $statusfile
echoerr Stamp file  : $stamp
echoerr Log file    : $logfile
echoerr
trap 1>&2
echoerr

# }}}1

# Initialisation du fichier état {{{1

if ! [ -f $statusfile ]
then
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
fi

# }}}1

# {{{ Boucle

while true
do
	# Lecture du fichier état {{{2

	[[ $statusfile -nt $stamp ]] && {

		touch $stamp

		while read ligne
		do
			ligne=${ligne// }
			eval $ligne
		done < $statusfile

		(( temps = minutes * 60 + seconds ))

		echoerr "*** Fichier état rechargé ***"
		echoerr
		echoerr Dispersion  : $dispersion
		echoerr Minutes     : $minutes
		echoerr Seconds     : $seconds
		echoerr Time        : $temps
		echoerr Meta        : $meta
		echoerr Current     : $current
		echoerr Reload      : $reload
		echoerr Stop        : $stop
		echoerr Status file : $statusfile
		echoerr Stamp file  : $stamp
		echoerr Log file    : $logfile
		echoerr
	}

	# }}}2

	# Arrêt {{{2

	(( stop > 0 )) && signal-stop

	# }}}2

	# Fin de la liste {{{2

	(( current >= Nimages )) && reload=1

	# }}}2

	# reload {{{2

	if (( reload == 1 ))
	then
		gen-random-list.zsh $dispersion $meta &>>! ~/log/gen-random-list.log
		images=($(cat $liste))
		current=1
		Nimages=${#images}
	fi

	reload=0

	# }}}2

	# Choix du fond d’écran {{{2

	fond=$images[$current]

	# }}}2

	# Date et heure {{{2

	dateHeure=`date +"%a %d %b %Y, %H:%M"`

	echo $dateHeure : $current : $fond

	# }}}2

	# Changement du fond d’écran {{{2

	feh --bg-max --no-fehbg $fond

	# }}}2

	# Lien symbolique {{{2

	# Pour i3lock

	lien=~/racine/run/wall/current

	[ -L $lien ] && rm -f $lien

	ln -s $fond $lien

	# }}}2

# Ecriture du fichier état {{{2

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

# }}}2

	# Attente {{{2

	# Pour ne pas retarder l’interception des traps

	sleep $temps &
	attendre=$!
	wait $attendre

	# }}}2

	# Incrément {{{2

	(( current ++ ))

	# }}}2

done

# }}}
