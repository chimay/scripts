#!/usr/bin/env sh

textfile=${1:-"textfile"}
language=${2:-"en-US"}

rootname=${textfile%.*}

echo "pico-tts -l fr-FR < $textfile > $rootname.wav"
echo
pico-tts -l $language < $textfile > $rootname.raw

# listen to the result :
# aplay -q -f S16_LE -r 16 $rootname.wav

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
