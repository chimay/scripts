#! /usr/bin/env zsh

# {{{ Options de zsh

setopt null_glob
setopt extended_glob

# }}}

# Fonctions {{{1

echoerr () {
	print "$@" >&2
}

signal-recharge () {
	echoerr
	echoerr "recharge -> 1"
	echoerr
	recharge=1
}

signal-suivant () {
	echoerr
	echoerr "suivant -> 1"
	echoerr
	[ -z $attendre ] || kill $attendre
}

signal-arret () {
	echoerr "arret -> 1"
	echoerr
	echoerr "On arrête fond-ecran"
	echoerr

	arret=1

	cat <<- fin >| $etat
		dispersion = $dispersion
		minutes = $minutes
		secondes = $secondes
		generation = $generation
		racine = $racine
		courant = $courant
		recharge = 0
		arret = 0
		etat = $etat
		temoin = $temoin
	fin

	exit 128
}

trap signal-recharge SIGUSR1
trap signal-suivant  SIGUSR2

trap signal-arret    HUP INT TERM

# }}}1

# Nettoyage {{{1

rm -f ~/graphix/wallpaper/**/*.exiv2_temp

# }}}1

# Initialisation {{{1

integer dispersion=12

integer minutes=0
integer secondes=0

integer courant=1

generation=~/graphix/list/wallpaper.gen

# }}}1

# Lecture préliminaire du fichier état s’il existe déjà {{{1

etat=~/racine/run/wall/fond-ecran.etat

temoin=${etat/.?*/.temoin}

if [ -f $etat ]
then
	touch $temoin

	while read ligne
	do
		ligne=${ligne// }
		eval $ligne
	done < $etat

	(( temps = minutes * 60 + secondes ))

	echoerr
	echoerr "*** Lecture préliminaire du fichier état ***"
	echoerr
	echoerr Dispersion : $dispersion
	echoerr Minutes : $minutes
	echoerr Secondes : $secondes
	echoerr Temps : $temps
	echoerr Génération : $generation
	echoerr Racine : $racine
	echoerr Courant : $courant
	echoerr Recharge : $recharge
	echoerr Arrêt : $arret
	echoerr Fichier état : $etat
	echoerr Fichier témoin : $temoin
	echoerr
fi

# }}}1

# Arguments {{{1

while true
do
	case $1 in
		[0-9]##)
			dispersion=$1
			shift
			;;
		[0-9]##m)
			minutes=${1/m/}
			shift
			;;
		[0-9]##s)
			secondes=${1/s/}
			shift
			;;
		?*)
			generation=$1
			shift
			;;
		*)
			break
			;;
	esac
done

[[ $etat = $temoin ]] && temoin=${temoin}.temoin

(( minutes == 0 )) && (( secondes == 0 )) && minutes=30
(( temps = minutes * 60 + secondes ))

# }}}1

# Génération de la liste {{{1

liste=${generation/.?*/.m3u}

[ -f $liste ] || {
	genere-liste-melangee.py $dispersion $generation &>! ~/log/genere-liste-melangee.log
}

racine=$(cat $generation | grep 'root' | cut -d ' ' -f 2)

(( $#racine == 0 )) && racine=~/graphix

racine=$~racine
racine=${racine##*:}
racine=${racine// }

# }}}1

# Images {{{1

images=($(cat $liste))

Nimages=${#images}

courant=1

# }}}1

# Affichage {{{1

echoerr "*** Affichage avant la boucle ***"
echoerr
echoerr Dispersion : $dispersion
echoerr Minutes : $minutes
echoerr Secondes : $secondes
echoerr Temps : $temps
echoerr Génération : $generation
echoerr Racine : $racine
echoerr Courant : $courant
echoerr Recharge : $recharge
echoerr Arrêt : $arret
echoerr Fichier état : $etat
echoerr Fichier témoin : $temoin
echoerr
trap 1>&2
echoerr

#echoerr 'Sortie :'
#echoerr

#{ echo $sortie | sed 's/^/\t/' } 1>&2

# }}}1

# Initialisation du fichier {{{1

cat <<- fin >| $etat
	dispersion = $dispersion
	minutes = $minutes
	secondes = $secondes
	generation = $generation
	racine = $racine
	courant = $courant
	recharge = 0
	arret = 0
	etat = $etat
	temoin = $temoin
fin

# }}}1

# {{{ Boucle

cd $racine

while true
do
	# Lecture du fichier état {{{2

	[[ $etat -nt $temoin ]] && {

		touch $temoin

		while read ligne
		do
			ligne=${ligne// }
			eval $ligne
		done < $etat

		(( temps = minutes * 60 + secondes ))

		echoerr "*** Fichier état rechargé ***"
		echoerr
		echoerr Dispersion : $dispersion
		echoerr Minutes : $minutes
		echoerr Secondes : $secondes
		echoerr Temps : $temps
		echoerr Génération : $generation
		echoerr Racine : $racine
		echoerr Courant : $courant
		echoerr Recharge : $recharge
		echoerr Arrêt : $arret
		echoerr Fichier état : $etat
		echoerr Fichier témoin : $temoin
		echoerr
	}

	# }}}2

	# Fin de la liste {{{2

	(( courant >= Nimages )) && recharge=1

	# }}}2

	# Recharge {{{2

	if (( recharge == 1 ))
	then
		sortie=$(genere-liste-melangee.py $dispersion $generation)
		images=($(cat $liste))
		courant=1
		Nimages=${#images}
	fi

	recharge=0

	# }}}2

	# Arrêt {{{2

	(( arret > 0 )) && {

		echoerr "On arrête fond-ecran"
		echoerr

		break
	}

	# }}}2

	# Choix du fond d’écran {{{2

	fond=$images[$courant]

	# }}}2

	# Date et heure {{{2

	dateHeure=`date +"%a %d %b %Y, %H:%M"`

	echo $dateHeure : $courant : $fond

	# }}}2

	# Changement du fond d’écran {{{2

	feh --bg-max --no-fehbg $fond

	# }}}2

	# Lien symbolique {{{2

	# Pour i3lock

	lien=~/racine/run/wall/current

	[ -L $lien ] && rm -f $lien

	ln -s $racine/$fond $lien

	# }}}2

	# Incrément {{{2

	(( courant ++ ))

	# }}}2

	# Attente {{{2

	# Pour ne pas retarder l’interception des traps

	sleep $temps &
	attendre=$!
	wait $attendre

	# }}}2

done

# }}}
