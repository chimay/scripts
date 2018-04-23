#! /usr/bin/env zsh

setopt extended_glob

# Aide {{{1

[[ $1 == help ]] && {

	echo Usage : ${0##*/} -minimum +maximum duree vol=volume
	echo

	exit
}

# }}}1

# Variables {{{1

integer moyenne dispersion temps somme reste

reception=$HOME/audio/Sonnerie/ding/reception.ogg

bol_tibetain=$HOME/audio/Sonnerie/ding/bol-tibetain.ogg
bol_nepalais=$HOME/audio/Sonnerie/ding/bol-nepalais.ogg
bol_chantant=$HOME/audio/Sonnerie/ding/bol-chantant.ogg

clochette=$HOME/audio/Sonnerie/ding/clochette.ogg

yinyang=$HOME/audio/Sonnerie/ding/yinyang.ogg

fin=$HOME/audio/Sonnerie/notification/fin-meditation.ogg

# }}}1

# {{{ Arguments

minimum=10
maximum=60
duree=900
volume=10

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

echo "  Prélude"
echo "=============================="
echo
echo Minimum : $minimum
echo Maximum : $maximum
echo Durée : $duree
echo Volume : $volume
echo
echo Moyenne : $moyenne
echo Dispersion : $dispersion
echo

# }}}

# {{{ Fonctions

lecteur () {

	local fu_volume=$1
	local fu_fichier=$2

	echo "loadfile $fu_fichier 1" > ~/racine/run/fifo/mplayer

	echo "set volume $fu_volume" > ~/racine/run/fifo/mplayer
}

# }}}

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

		echo Somme : $somme
		echo
		echo Reste : $reste
		echo

		(( reste < 0 )) && {

			echo "Erreur : reste du temps négatif"
			echo

			exit 1
		}

		sleep $reste

		(( somme += reste ))

		echo Somme : $somme
		echo

		break
	}

	echo "sleep $temps"
	echo

	sleep $temps

	echo "lecteur $volume $reception"
	echo

	lecteur $volume $reception

	(( somme += temps ))

	echo Somme : $somme
	echo
done

# }}}

# {{{ Fin

echo "  Fin de la boucle"
echo "=============================="
echo
echo "   lecteur $volume <fin>"
echo

lecteur $volume $yinyang
lecteur $volume $bol_tibetain

lecteur $volume $fin

# }}}
