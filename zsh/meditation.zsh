#! /usr/bin/env zsh

setopt extended_glob

# Valeurs par défaut {{{1

float maximum minimum

minimum=10
maximum=60
duree=900
volume=100

# }}}1

# Aide {{{1

[ $# -gt 0 ] && [ $1 = help -o $1 = -h -o $1 = --help ] && {

	echo Usage : ${0##*/} -minimum +maximum duree vol=volume
	echo
	echo "Par défaut :"
	echo
	echo "    Minimum = $minimum"
	echo "    Maximum = $maximum"
	echo "    Durée   = $duree"
	echo "    Volume  = $volume"

	exit
}

# }}}1

# Variables {{{1

reception=$HOME/audio/Sonnerie/ding/reception.ogg
clochette=$HOME/audio/Sonnerie/ding/clochette.ogg
yinyang=$HOME/audio/Sonnerie/ding/yinyang.ogg

bol_chantant=$HOME/audio/Sonnerie/ding/bol-chantant.ogg
bol_nepalais=$HOME/audio/Sonnerie/ding/bol-nepalais.ogg
bol_tibetain=$HOME/audio/Sonnerie/ding/bol-tibetain.ogg

fin=$HOME/audio/Sonnerie/notification/fin-meditation.ogg

# }}}1

# {{{ Arguments

while true
do
	case $1 in
		-[0-9]##)
			minimum=${1#-}
			shift
			;;
		+[0-9]##)
			maximum=${1#+}
			shift
			;;
		[0-9]##)
			duree=$1
			shift
			;;
		vol=?*)
			volume=${1#vol=}
			shift
			;;
		*)
			break
			;;
	esac
done

# }}}

# Moyenne & Dispersion {{{1

(( moyenne = (maximum + minimum) / 2 ))
(( dispersion = (maximum - minimum) / 4 ))

# }}}1

# {{{ Affichage

echo "  Affichage"
echo "=============================="
echo
echo "Minimum : $minimum"
echo "Maximum : $maximum"
echo "Durée   : $duree  "
echo "Volume  : $volume "
echo
echo "Moyenne    : $moyenne   "
echo "Dispersion : $dispersion"
echo

# }}}

# {{{ Fonctions

lecteur () {

	local fu_volume=$1
	local fu_fichier=$2

	echo "loadfile $fu_fichier append-play" > ~/racine/run/fifo/mpv

	echo "set volume $fu_volume" > ~/racine/run/fifo/mpv
}

# }}}

# Temps pris pour lire $reception {{{1

temps_reception=0

sortie=$(ogginfo $reception | grep 'Playback length' | awk '{ print $3 }')

minutes=${sortie%m:*}

(( temps_reception += 60 * minutes ))

secondes=${sortie#*:}
secondes=${secondes:s/s/}

(( temps_reception += secondes ))

echo $sortie = $minutes minutes $secondes secondes
echo
echo temps_reception = $temps_reception
echo

# }}}1

# Prélude {{{1

echo "  Prélude avant la boucle"
echo "=============================="
echo
echo lecteur $volume $yinyang
echo lecteur $volume $bol_chantant
echo lecteur $volume $bol_nepalais
echo

lecteur $volume $yinyang
lecteur $volume $bol_chantant
lecteur $volume $bol_nepalais

# }}}1

# On dort pendant que le prélude joue {{{1

total=0

for fichier in $yinyang $bol_chantant $bol_nepalais
do
	sortie=$(ogginfo $fichier | grep 'Playback length' | awk '{ print $3 }')

	minutes=${sortie%m:*}

	(( total += 60 * minutes ))

	secondes=${sortie#*:}
	secondes=${secondes:s/s/}

	(( total += secondes ))

	echo $sortie = $minutes minutes $secondes secondes
	echo
	echo total = $total
	echo
done

sleep $total

# }}}1

# {{{ Boucle

somme=0

while true
do
	echo "  Passage dans la boucle"
	echo "=============================="
	echo

	temps=$(alea.py $moyenne $dispersion)

	(( temps < $minimum )) && temps=$minimum
	(( temps > $maximum )) && temps=$maximum

	(( somme + temps >= duree )) && {

		(( reste = duree - somme ))

		echo Temps : $temps
		echo
		echo Somme : $somme
		echo
		echo Reste : $reste
		echo

		(( reste < 0 )) && {

			echo "Erreur : reste du temps négatif"
			echo

			exit 1
		}

		echo "sleep $reste"
		echo

		sleep $reste

		(( somme += reste ))

		echo "------------------------------"
		echo
		echo Somme : $somme
		echo

		break
	}

	(( somme += temps ))

	echo Temps : $temps
	echo
	echo Somme : $somme
	echo

	echo "sleep $temps"
	echo

	sleep $temps

	echo "lecteur $volume $reception"
	echo

	lecteur $volume $reception

	echo "sleep $temps_reception"
	echo

	sleep $temps_reception
done

# }}}

# {{{ Conclusion

echo "  Conclusion après la boucle"
echo "=============================="
echo
echo lecteur $volume $yinyang
echo lecteur $volume $clochette
echo lecteur $volume $bol_tibetain
echo
echo lecteur $volume $fin

lecteur $volume $yinyang
lecteur $volume $clochette
lecteur $volume $bol_tibetain

lecteur $volume $fin

# }}}
