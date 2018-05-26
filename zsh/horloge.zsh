#! /usr/bin/env zsh

setopt extended_glob

#  {{{ Déjà une horloge qui tourne ?

grep="/bin/grep --color=never"

ps auxww | $=grep -v grep | $=grep -v $$ | $=grep horloge.zsh && {

	echo "L’horloge tourne déjà"
	exit 0
}

#  }}}

#  {{{ Initialisation

integer intervalle=15
integer frequence=4
integer decalage=0
integer ante=0
integer post=0

integer carillon=1
integer vocal=1

integer volume=100

integer finance=0

integer ecole=0

integer pause=0
integer arret=0

integer jour_semaine=`date +%u`

etat=$HOME/racine/run/clock/horloge.etat

remonter=$HOME/audio/Sonnerie/horloge/remonter.ogg
tictac=$HOME/audio/Sonnerie/horloge/tictac.ogg

bol=$HOME/audio/Sonnerie/horloge/bol-tibetain.ogg
yinyang=$HOME/audio/Sonnerie/horloge/yinyang.ogg

chercher=$HOME/audio/Sonnerie/notification/ecole.ogg

carillon_simple=$HOME/audio/Sonnerie/horloge/coucou-1.ogg

#  }}}

# {{{ Arguments

while true
do
	case $1 in
		+[0-9]##)
			intervalle=${1#+}
			frequence=$(( 60 / intervalle ))
			shift
			;;
		-[0-9]##)
			frequence=${1#-}
			intervalle=$(( 60 / frequence ))
			shift
			;;
		-d)
			shift
			decalage=$1
			shift
			;;
		-a)
			shift
			ante=$1
			shift
			;;
		-p)
			shift
			post=$1
			shift
			;;
		+c)
			carillon=2
			shift
			;;
		-c)
			shift
			carillon=1
			;;
		-C)
			shift
			carillon=0
			;;
		+v)
			vocal=2
			shift
			;;
		-v)
			vocal=1
			shift
			;;
		-V)
			vocal=0
			shift
			;;
		[0-9]##)
			volume=$1
			shift
			;;
		-f)
			shift
			finance=1
			;;
		-F)
			shift
			finance=0
			;;
		-e)
			shift
			ecole=1
			;;
		-E)
			shift
			ecole=0
			;;
		-i)
			shift
			etat=$1
			shift
			;;
		?*)
			shift
			;;
		*)
			break
			;;
	esac
done

temoin=${etat/.?*/.temoin}

[[ $etat = $temoin ]] && temoin=${temoin}.temoin

# }}}

# {{{ Fonctions

lecteur () {

	local fu_volume=$1
	local fu_fichier=$2

	echo "loadfile $fu_fichier 1" > ~/racine/run/fifo/mplayer

	echo "set volume $fu_volume" > ~/racine/run/fifo/mplayer
}

# }}}

#  {{{ Affichage

echo
echo '========================================================================'
date +"   Démarrage le %A %d %B %Y  (o) %H : %M : %S  | %:z | "
echo '========================================================================'
echo

echo "   Intervalle = $intervalle"
echo "   Frequence = $frequence"
echo
echo "   Decalage = $decalage"
echo
echo "   Ante = $ante"
echo "   Post = $post"
echo
echo "   Carillon = $carillon"
echo "   Vocal = $vocal"
echo
echo "   Volume = $volume"
echo
echo "   Finance = $finance"
echo "   Ecole = $ecole"
echo
echo "   Etat = $etat"
echo "   Temoin = $temoin"
echo
echo "   Pause = $pause"
echo
echo "   Arret = $arret"
echo
echo "   Jour = $jour_semaine"
echo

#  }}}

#  {{{ Initialisation du fichier

cat <<- fin >| $etat

	# vim: set filetype=conf :

	intervalle = $intervalle

	decalage = $decalage

	ante = $ante

	post = $post

	carillon = $carillon

	vocal = $vocal

	volume = $volume

	finance = $finance

	ecole = $ecole

	etat = $etat

	temoin = $temoin

	pause = $pause

	arret = $arret
fin

touch $temoin

#  }}}

#  {{{ Retard initial

echo "   lecteur $volume $remonter"
echo "   lecteur $volume $tictac"
echo

lecteur $volume $remonter
lecteur $volume $tictac

secondes=`date +%S`

retard=$(( 60 - secondes ))

echo '   On a initialement' $secondes 'secondes de retard, on dort' $retard 'secondes'
echo

sleep $retard

#  }}}

#  {{{ Boucle

while true
do

#  {{{ Affichage

echo "------------------------------"
echo

date +"   [=] %A %d %B %Y  (o) %H : %M : %S  | %:z | "
echo

#  }}}

#  {{{ Lecture du fichier

[[ $etat -nt $temoin ]] && {

	touch $temoin

	while read ligne
	do
		ligne=${ligne// }

		eval $ligne

	done < $etat

	echo "   Intervalle = $intervalle"
	echo
	echo "   Decalage = $decalage"
	echo
	echo "   Ante = $ante"
	echo "   Post = $post"
	echo
	echo "   Carillon = $carillon"
	echo "   Vocal = $vocal"
	echo
	echo "   Volume = $volume"
	echo
	echo "   Finance = $finance"
	echo "   Ecole = $ecole"
	echo
	echo "   Etat = $etat"
	echo "   Temoin = $temoin"
	echo
	echo "   Pause = $pause"
	echo
	echo "   Arret = $arret"
	echo

	echo "   lecteur $volume $remonter"
	echo "   lecteur $volume $tictac"
	echo

	lecteur $volume $remonter
	lecteur $volume $tictac
}

#  }}}

# {{{ Pause

(( pause > 0 )) && {

	echo "    L’horloge est en pause"
	echo
	echo "    On dort 15 minutes"
	echo

	sleep 900

	secondes=`date +%S`

	retard=$(( 60 - secondes ))

	echo '   On a' $secondes 'secondes de retard, on dort' $retard 'secondes'
	echo

	sleep $retard

	continue
}

# }}}

# {{{ Arrêt

(( arret > 0 )) && {

	echo "On arrête l’horloge"
	echo

	break
}

# }}}

#  {{{ Variables

dingdong=0

fifi=0
craie=0

integer heure minute

heure=`date +%H`
minute=`date +%M`

# Format 00 .. 23 & 00 .. 59

HH=`date +%H`
MM=`date +%M`

jour_semaine=`date +%u`

# echo Heure : $heure
# echo
# echo Minutes : $minute
# echo
# echo Jour de la semaine : $jour_semaine
# echo

#  }}}

# {{{ Finance

	(( finance == 1 )) && \
		(( jour_semaine >= 1 )) && \
		(( jour_semaine <= 5 )) && {

		(( heure == 8 && minute == 53 )) && fifi=1

		(( heure == 17 && minute == 23 )) && fifi=1

		(( heure == 15 && minute == 30 )) && fifi=1

		(( heure == 22 && minute == 0 )) && fifi=1

		# ------------------------------

		(( heure == 10 && minute == 0 )) && fifi=1

		(( heure == 12 && minute == 0 )) && fifi=1

		(( heure == 14 && minute == 0 )) && fifi=1

		(( heure == 15 && minute == 0 )) && fifi=1

		(( heure == 16 && minute == 0 )) && fifi=1
	}

# }}}

# {{{ Ecole

	(( ecole == 1 )) && \
		(( jour_semaine >= 1 )) && \
		(( jour_semaine <= 5 )) && {

		(( jour_semaine != 3 )) && (( heure == 15 && minute == 21 )) && craie=1

		(( jour_semaine == 3 )) && (( heure == 11 && minute == 31 )) && craie=1
	}

# }}}

#  {{{ Sonnerie finance

	(( fifi == 1 )) && {

		#dingdong=1

		echo "   lecteur $volume $bol"
		echo "   lecteur $volume $yinyang"
		echo "   lecteur $volume $bol"
		echo

		lecteur $volume $bol
		lecteur $volume $yinyang
		lecteur $volume $bol
	}

#  }}}

#  {{{ Sonnerie ecole

	(( craie == 1 )) && {

		echo "   lecteur $volume $chercher"
		echo

		lecteur $volume $chercher
	}

#  }}}

#  {{{ Quand sonner ?

	(( minute = minute - decalage ))

	(( minute % intervalle == 0 )) && dingdong=1

#  }}}

#  {{{ Ante / Post

	(( (minute + ante) % intervalle == 0 )) && dingdong=1

	(( (minute - post) % intervalle == 0 )) && dingdong=1

#  }}}

#  {{{ Sonnerie principale

	(( dingdong == 1 )) && {

		(( carillon == 2 )) && {

			cloche=$HOME/audio/Sonnerie/horloge/carillon-$HH-$MM.ogg

			[[ -f $cloche ]] || cloche=$HOME/audio/Sonnerie/horloge/carillon-HH-$MM.ogg

			[[ -f $cloche ]] || cloche=$HOME/audio/Sonnerie/horloge/carillon-HH-MM.ogg

			echo "   lecteur $volume $cloche"
			echo

			lecteur $volume $cloche
		}

		(( carillon == 1 )) && {

			echo "   lecteur $volume $carillon_simple"
			echo

			lecteur $volume $carillon_simple
		}

		(( vocal == 2 )) && {

			voix=$HOME/audio/Sonnerie/horloge/vocal-$HH-$MM.ogg

			[[ -f $voix ]] || voix=$HOME/audio/Sonnerie/horloge/vocal-HH-$MM.ogg

			echo "   lecteur $volume $voix"
			echo

			lecteur $volume $voix
		}

		(( vocal == 1 )) && {

			voix=$HOME/audio/Sonnerie/horloge/vocal-HH-$MM.ogg

			echo "   lecteur $volume $voix"
			echo

			lecteur $volume $voix

			#saytime
		}

		date +"   [=] %A %d %B %Y  (o) %H : %M : %S  | %:z | "
		echo
}

#  }}}

#  {{{ Retard

	secondes=`date +%S`

	retard=$(( 60 - secondes ))

	echo '   On a' $secondes 'secondes de retard, on dort' $retard 'secondes'
	echo

	sleep $retard

#  }}}

done

#  }}}
