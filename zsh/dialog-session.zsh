#!/usr/bin/env /bin/zsh

liste=(~/racine/config/multiplex/tmux/session/*)

numero=1
tagitem=()

for element in $~liste
do
	tagitem+=($numero $element)
	(( numero += 1 ))
done

exec 3>&1
choix=$(dialog --menu "Liste" 0 0 0 $=tagitem 2>&1 1>&3)
exec 3>&-

code=$?

fichier=$~liste[$choix]

echo Fichier : $fichier
echo

(( $code > 0)) && exit 1

(( $#fichier == 0 )) && exit 0

echo Fichier : $fichier
echo

tmux source-file $fichier
