#!/usr/bin/env sh

audiofile=${1:-"audiofile"}
text=${2:-"Example text."}
language=${3:-"en-US"}

echo pico2wave -l fr-FR -w $audiofile.wav $text
echo
pico2wave -l $language -w $audiofile.wav "$text"

echo
echo "------------------------------"
echo

echo ffmpeg -i "$audiofile.wav" -threads 2 -vn -codec:a libvorbis -q:a 7 -ac 2 "$audiofile-tmp.ogg"
echo
ffmpeg -i "$audiofile.wav" -threads 2 -vn -codec:a libvorbis -q:a 7 -ac 2 "$audiofile-tmp.ogg"

echo
echo "------------------------------"
echo

echo sox $audiofile-tmp.ogg $audiofile.ogg pad 0.5 0.5
echo
sox $audiofile-tmp.ogg $audiofile.ogg pad 0.5 0.5

echo
echo "------------------------------"
echo

echo rm -rf $audiofile.wav $audiofile-tmp.ogg
echo
rm -rf $audiofile.wav $audiofile-tmp.ogg
