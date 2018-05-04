#! /usr/bin/env zsh

# Usage : archivemail.sh <date> <boiteAuxLettres>

annee=$(date +%Y)

archdir=~/racine/mail/Archives/$annee

[ -d $archdir ] || mkdir -p $archdir

# {{{ Fanions de zsh

setopt extended_glob

# }}}

# {{{ Arguments

fanions=()

while true
do
	case $1 in
		-*)
			fanions+=$1
			shift
			;;
		[0-9-]*)
			date=$1
			shift
			;;
		?*)
			boite=$1
			shift
			;;
		*)
			break
			;;
	esac
done

# }}}

# {{{ Date

# -s suffixe :
# %Y : année 4 chiffres
# %m : mois
# %d : jour

# date peut être un nombre de jour maximum d’ancienneté ou
# une date année-mois-jour

case $date in
	[0-9]##)
		delai="-d $date"
		;;
	[0-9][0-9-]##)
		delai="-D $date"
		;;
	*)
		echo "Erreur de format de date/anciennete des messages"
		exit 1
		;;
esac

# }}}

# {{{ Archivemail

if [[ $fanions[(i)--delete] -gt $#fanions ]]
then
	echo "Pas de delete dans les options"
	echo
	echo "exec archivemail $=fanions --include-flagged $=delai -s '-%Y' -o $archdir $boite"
	echo

	exec archivemail $=fanions --include-flagged $=delai -s '-%Y' -o $archdir $boite
else
	echo "On a delete dans les options"
	echo
	echo "exec archivemail $=fanions --include-flagged $=delai $boite"
	echo

	exec archivemail $=fanions --include-flagged $=delai $boite
fi

# }}}
