#! /usr/bin/env zsh

# vim: set conceallevel=0 :

repertoire=$1

(( $#repertoire > 0 )) || repertoire=$(zenity --file-selection --directory)

(( $#repertoire > 0 )) || exit 0

echo "cd $repertoire"
echo

cd $repertoire

fichiers=($(print -l *(.) | sxiv -tio))

destination=$(zenity --file-selection --directory)

(( $#destination > 0 )) || exit 0

for fich in $fichiers
do
	[ -e $destination/$fich ] || mv $fich $destination
done
