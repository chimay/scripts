#!/usr/bin/env zsh

url=$1
sortie=$2
temps=${3:-01:10:00.00}

#addresse=$(yt-dlp -f 140 -g $url)
addresse=$(yt-dlp -f 140 -g $url)

echo "ffmpeg -i \"$addresse\" -t $temps $sortie.mp3"
echo

ffmpeg -i "$addresse" -t $temps $sortie.mp3
