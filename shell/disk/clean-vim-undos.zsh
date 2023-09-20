#! /usr/bin/env zsh

# Supprime les .*.un~ dont le fichier associé n'existe plus

# {{{ Options de zsh

setopt extended_glob

# }}}

for fichierUndo in **/.*.un~
do
	fichier=${fichierUndo/(#b)(?*)\/.(*).un~/$match[1]\/$match[2]}

	#echo $fichierUndo / $fichier

	if [[ ! -f $fichier ]]
	then
		echo "rm $fichierUndo"

		rm $fichierUndo
	fi
done
