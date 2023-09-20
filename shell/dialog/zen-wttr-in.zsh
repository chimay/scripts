#!/usr/bin/env zsh

lieu=${1:-Paris}

export PATH=$PATH:~/racine/bin/go/bin

fichier=~/log/wttr-in.log

choix=$(zenity  --list  --text "Que faire ?" --radiolist  --column "Choix" --column "Action" TRUE "Afficher" FALSE "Rafraîchir" )

echo Choix : $choix

(( $#choix == 0 )) && exit 0

[ $choix = Rafraîchir ] && {

	echo
	echo "=================================="
	echo " " $(date +"%H : %M %A %d %B %Y")
	echo "=================================="
	echo

	curl wttr.in/$lieu 2>~/log/wttr-in.err.log

} >>! $fichier

urxvtc -geometry 130x47 -e less -f +G $fichier
