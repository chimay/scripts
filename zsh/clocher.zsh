#! /usr/bin/env zsh

player () {

	local fu_volume=$1
	local fu_fichier=$2

	mpv-socket.bash add $fu_fichier
	mpv-socket.bash volume 100
}

HH=`date +%H`
MM=`date +%M`

echo -n $HH:$MM

fichier=~/racine/run/clock/clocher.etat

[ -f $fichier  ] && {
	etat=$(<$fichier)
	(( etat == 0 )) && {
		echo "   etat == 0 : no bell"
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
		echo "   ERROR : bad format of $MM minutes"
		exit 0
		;;
esac

echo "   player $volume $cloche"

player $volume $cloche
