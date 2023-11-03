#! /usr/bin/env zsh

setopt extended_glob

export WGETRC=${HOME}/racine/config/network/wget/aspirateur

# temporaire=wget.$$
temporaire=$(mktemp)

#minime=$HOME/racine/config/edit/vim/rc-viminime.vim

integer niveau=1

adresse=""

# Fanions {{{1

# Certains fanions peuvent poser problème dans certains cas, notamment :
#
# 	--no-parent
# 	--relative
# 	--no-host-directories
#
#	Ne pas hésiter à les ajouter/enlever lors de l’édition proposée par le script

fanions=(
	--recursive
	--no-parent
	--page-requisites
	--convert-links
	--adjust-extension
	--ignore-case
	--reject .mid,.midi,.mp3,.ogg,.wav,.ogv,.mp4,.m4v,.avi,.webm,.swf,.flv,.zip,.tar.gz,.tar.bz2
	--backups=0
	--user-agent=firefox
	--wait=1
	--random-wait
	--tries=4
	--timeout=12
	--timestamping
	--progress=bar
	-b
	-o wget.log
)

# }}}1

# {{{ Arguments

while true
do
	case $1 in
		[0-9]##)
			niveau=$1
			shift
			;;
		-*)
			fanions+=$1
			shift
			;;
		http://*)
			adresse=$1
			shift
			;;
		*//*)
			adresse=$1
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

# }}}

# Adaptations {{{1

(( $#adresse > 0 )) || exit 0

fanions+="--level=${niveau}"

# }}}1

# Affichage {{{1

echo Adresse : $adresse
echo
echo Niveau : $niveau
echo
echo fanions : $fanions
echo
echo "=============================="
echo

# }}}1

# Solution avec fichier temporaire {{{1

echo "wget $fanions -- $adresse" > $temporaire
echo

vim $temporaire

code=$?

[ $code -gt 0 ] && {
	echo vim exited with error code $code : wget not launched.
	exit $?
}

chaine='ligne=$(<'$temporaire')'

eval $chaine

echo "$ligne"
echo

$=ligne

rm $temporaire

# }}}1
