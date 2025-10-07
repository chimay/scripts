#!/usr/bin/env sh

[ $# -gt 0 ] || {
	echo Usage : $0 score-title [measure-type [3-2-4]]
	echo
	exit 0
}

title=$1
measure=${2:-"3-2-4"}

echo "cd ~/racine/musica/lilypond/template"
echo
cd ~/racine/musica/lilypond/template

echo "cp -f meta.ly ../score/$title.ly"
echo
cp -f meta.ly ../score/$title.ly

echo "cp -f melody/mel-$measure.mld.ly ../score/melody/$title-$measure.mld.ly"
echo
cp -f melody/mel-$measure.mld.ly ../score/melody/$title.mld.ly
