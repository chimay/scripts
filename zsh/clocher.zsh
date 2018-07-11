#! /usr/bin/env zsh

volume=${1:-100}

# {{{ Fonctions

lecteur () {

	local fu_volume=$1
	local fu_fichier=$2

	echo "loadfile $fu_fichier append-play" > ~/racine/run/fifo/mpv

	echo "set volume $fu_volume" > ~/racine/run/fifo/mpv
}

# }}}

HH=`date +%H`
MM=`date +%M`

echo -n $HH:$MM

case $MM in
	00) cloche=$HOME/audio/Sonnerie/horloge/carillon-$HH-00.ogg ;;
	15) cloche=$HOME/audio/Sonnerie/horloge/coucou-1.ogg ;;
	30) cloche=$HOME/audio/Sonnerie/horloge/coucou-2.ogg ;;
	45) cloche=$HOME/audio/Sonnerie/horloge/coucou-3.ogg ;;
	??)
		cloche=$HOME/audio/Sonnerie/horloge/carillon-$HH-$MM.ogg
		[[ -f $cloche ]] || cloche=$HOME/audio/Sonnerie/horloge/carillon-HH-$MM.ogg
		[[ -f $cloche ]] || cloche=$HOME/audio/Sonnerie/horloge/carillon-HH-MM.ogg
		;;
	*) echo "Erreur : mauvais format de $MM minutes"
esac

echo "   lecteur $volume $cloche"

lecteur $volume $cloche
