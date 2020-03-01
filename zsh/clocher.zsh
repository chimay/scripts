#! /usr/bin/env zsh

# {{{ Fonctions

lecteur () {

	local fu_volume=$1
	local fu_fichier=$2

	echo "loadfile $fu_fichier append-play" > ~/racine/run/pipe/mpv

	echo "set volume $fu_volume" > ~/racine/run/pipe/mpv
}

# }}}

HH=`date +%H`
MM=`date +%M`

echo -n $HH:$MM

fichier=~/racine/run/clock/clocher.etat

[ -f $fichier  ] && {

	etat=$(<$fichier)

	(( etat == 0 )) && {

		echo "   etat == 0 : on ne sonne pas"

		exit 0
	}
}

volume=${1:-$etat}

case $MM in
	00) cloche=$HOME/audio/sonnerie/horloge/carillon-$HH-00.ogg ;;
	15) cloche=$HOME/audio/sonnerie/horloge/coucou-1.ogg ;;
	30) cloche=$HOME/audio/sonnerie/horloge/coucou-2.ogg ;;
	45) cloche=$HOME/audio/sonnerie/horloge/coucou-3.ogg ;;
	??)
		cloche=$HOME/audio/sonnerie/horloge/carillon-$HH-$MM.ogg
		[[ -f $cloche ]] || cloche=$HOME/audio/sonnerie/horloge/carillon-HH-$MM.ogg
		[[ -f $cloche ]] || cloche=$HOME/audio/sonnerie/horloge/carillon-HH-MM.ogg
		;;
	*)
		echo "   ERREUR : mauvais format de $MM minutes"
		exit 0
		;;
esac

echo "   lecteur $volume $cloche"

lecteur $volume $cloche
