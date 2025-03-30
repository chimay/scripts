#!/usr/bin/env sh

[ $# -eq 0 -o x$1 = x-h -o x$1 = x--help ] && {
    echo "Usage : $(basename $0) htmlfile language options"
	echo
	echo language is en-US by default
	echo
	echo Options :
	echo
	echo "-nr : don't use readable to shorten html page (default)"
	echo "-r : use readable to shorten html page"
	echo
	echo Prerequisites : readable w3m pico-tts sox ffmpeg
	echo
	echo "See https://github.com/Iiridayn/pico-tts for pico-tts. There is also an AUR package."
    exit 0
}

htmlfile=${1:-"htmlfile"}
language=${2:-"en-US"}
use_readable=${3:-"-nr"}

rootname=${htmlfile%.*}

if [ $use_readable = "-r" ]
then
	echo "readable $htmlfile > $rootname.rdbl.html"
	echo
	readable $htmlfile > $rootname.rdbl.html
else
	echo "cp $htmlfile $rootname.rdbl.html"
	echo
	cp $htmlfile $rootname.rdbl.html
fi

echo
echo "------------------------------"
echo

echo "w3m -dump $rootname.rdbl.html > $rootname.txt"
echo
w3m -dump $rootname.rdbl.html > $rootname.txt

echo
echo "------------------------------"
echo

echo "pico-tts -l $language < $rootname.txt > $rootname.raw"
echo
pico-tts -l $language < $rootname.txt > $rootname.raw

# listen to the result :
# aplay -q -f S16_LE -r 16 $rootname.raw

echo
echo "------------------------------"
echo

echo sox -r 16k -e signed -b 16 $rootname.raw -c 1 -b 16 $rootname.wav
echo
sox -r 16k -e signed -b 16 $rootname.raw -c 1 -b 16 $rootname.wav

echo
echo "------------------------------"
echo

echo ffmpeg -i "$rootname.wav" -threads 2 -vn -codec:a libvorbis -q:a 7 -ac 2 "$rootname-tmp.ogg"
echo
ffmpeg -i "$rootname.wav" -threads 2 -vn -codec:a libvorbis -q:a 7 -ac 2 "$rootname-tmp.ogg"

echo
echo "------------------------------"
echo

echo sox $rootname-tmp.ogg $rootname.ogg pad 0.5 0.5
echo
sox $rootname-tmp.ogg $rootname.ogg pad 0.5 0.5

echo
echo "------------------------------"
echo

echo rm -rf $rootname.raw $rootname.wav $rootname-tmp.ogg
echo
rm -rf $rootname.raw $rootname.wav $rootname-tmp.ogg
