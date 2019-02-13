#! /usr/bin/env zsh

# vim: set conceallevel=0 :

repertoire=$(zenity --file-selection --directory)

(( $#repertoire > 0 )) || exit 0

cd $repertoire

fichiers=$(print -l * | sort -t - -k 2)

urxvtc -e mocp $=fichiers &

#sleep 1

#mocp -G
