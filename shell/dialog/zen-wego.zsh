#!/usr/bin/env zsh

export PATH=$PATH:~/racine/bin/go/bin

fichier=~/log/wego.log

choix=$(zenity  --list  --text "Que faire ?" --radiolist  --column "Choix" --column "Action" TRUE "Afficher" FALSE "Rafraîchir" )

echo Choix : $choix

(( $#choix == 0 )) && exit 0

[ $choix = Rafraîchir ] && {

	echo
	echo "=================================="
	echo " " $(date +"%H : %M %A %d %B %Y")
	echo "=================================="
	echo

	wego

} >>! $fichier

urxvtc -name meteo -geometry 130x43 -e less -f -r +G $fichier
