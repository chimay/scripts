#!/usr/bin/env zsh

# Aide {{{1

[ $# -eq 0 ] && {
	echo Usage : ${0##*/} folder
	exit
}

# }}}1

folder=$1

cd $folder

for epub in **/*.epub
do
	text=${epub%.epub}.txt
	echo "epub2txt $epub > $text"
	epub2txt $epub > $text
done

cd -
