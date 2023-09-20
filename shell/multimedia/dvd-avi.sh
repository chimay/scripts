#! /usr/bin/env sh

[ $# -eq 0 ] && {
	echo "Usage : ${0##*/} <titre> <langue-audio> <langue-sous-titre> <fichierSortie>"

	exit 0
}

titre=$1
device=$2
audio=$3
soustitre=$4
fichier=$5

echo "mencoder dvd://$titre -dvd-device $device \
-alang $audio -slang $soustitre \
-oac mp3lame -lameopts br=320:cbr -ovc lavc -lavcopts vcodec=mpeg4:vhq \
-vf scale -zoom -xy 800 \
-o ${fichier}.avi"

echo

mencoder dvd://$titre -dvd-device $device \
	-alang $audio -slang $soustitre \
	-oac mp3lame -lameopts br=320:cbr -ovc lavc -lavcopts vcodec=mpeg4:vhq \
	-vf scale -zoom -xy 800 \
	-o ${fichier}.avi
