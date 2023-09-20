#! /usr/bin/env zsh

# {{{ Options de zsh

setopt null_glob
setopt extended_glob
unsetopt case_glob

# }}}

racine=${1:-~/photo}
dest=${2:-${racine}/tri-par-date}

[[ -d $dest ]] || {

	echo "mkdir $dest"
	echo ""

	mkdir -p $dest
}

for fichier in ${racine}/**/*.(svg|png|jpg|jpeg|gif)(om.)
do

# {{{ Boucle jusqu'au moment ou la commande de méta-infos réussit

	# Pourquoi ça ne réussit pas toujours du premier coup ?

	temps=''
	compteur=0

	while [[ $temps != *[0-9](#c4):[0-9](#c2):[0-9](#c2)* ]] && (( compteur <= 12 ))
	do
		(( compteur++ ))
		temps=`exiv2 pr $fichier | egrep '(Horodatage|Image timestamp)'`
		#temps=`exiv2 pr $fichier | grep Horodatage | cut -d ' ' -f 4`
	done

# }}}

# {{{ Réduction

# {{{ Par éliminations successives

	#temps=${temps/Horodatage de l\'image: }

	#temps=${temps/%([0-9](#c2):)(#c2)[0-9](#c2)}

	#temps=${temps/ }

	#mois=${temps/%-[0-9](#c2)}

# }}}

# <-- OU -->

# {{{ Utilise les rétro-références

	mois=${temps/(#b)*([0-9](#c4):[0-9](#c2)):[0-9](#c2)*/$match[1]}

# }}}

# }}}

# {{{ Format 2012/12-decembre

	mois=${mois//:/-}

	case $mois in
		(*-01) mois=${mois/(#b)([0-9](#c4))-01/$match[1]\/01-janvier} ;;
		(*-02) mois=${mois/(#b)([0-9](#c4))-02/$match[1]\/02-fevrier} ;;
		(*-03) mois=${mois/(#b)([0-9](#c4))-03/$match[1]\/03-mars} ;;
		(*-04) mois=${mois/(#b)([0-9](#c4))-04/$match[1]\/04-avril} ;;
		(*-05) mois=${mois/(#b)([0-9](#c4))-05/$match[1]\/05-mai} ;;
		(*-06) mois=${mois/(#b)([0-9](#c4))-06/$match[1]\/06-juin} ;;
		(*-07) mois=${mois/(#b)([0-9](#c4))-07/$match[1]\/07-juillet} ;;
		(*-08) mois=${mois/(#b)([0-9](#c4))-08/$match[1]\/08-aout} ;;
		(*-09) mois=${mois/(#b)([0-9](#c4))-09/$match[1]\/09-septembre} ;;
		(*-10) mois=${mois/(#b)([0-9](#c4))-10/$match[1]\/10-octobre} ;;
		(*-11) mois=${mois/(#b)([0-9](#c4))-11/$match[1]\/11-novembre} ;;
		(*-12) mois=${mois/(#b)([0-9](#c4))-12/$match[1]\/12-decembre} ;;
	esac

# }}}

# {{{ Déplacement

	echo ${fichier%?*/} x $compteur '==>' $mois
	echo

	destination=${dest}/${mois}

	[[ -d $destination ]] || {

		echo "mkdir $destination"
		echo

		mkdir -p $destination
	}

	echo "mv $fichier $destination"
	echo
	echo "------------------------------------"
	echo

	mv $fichier $destination

# }}}

done

cd -
