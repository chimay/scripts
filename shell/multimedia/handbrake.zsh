#! /usr/bin/env zsh

# vim: set conceallevel=0 :

(( $# == 0 )) && {

	echo "handbrake.zsh film titre audio"
	exit 0
}

film=$1

titre=${2:-1}
audio=${3:-1}

# lsdvd -as -t $titre /dev/sr0

echo "HandBrakeCLI -i /dev/sr0 -o $PWD/$film.mkv -f av_mkv -t $titre -N fra -s scan -F -a $audio"
echo
 
HandBrakeCLI -i /dev/sr0 -o $PWD/$film.mkv -f av_mkv -t $titre -N fra -s scan -F -a $audio

mkvinfo $film.mkv
