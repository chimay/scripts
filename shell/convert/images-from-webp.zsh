#!/usr/bin/env zsh

setopt extended_glob

folder=${1:-.}

cd $folder

for image in **/*.(webp|WEBP)
do
	pngfile=${image%.*}.png
	jpegfile=${image%.*}.jpg
	echo "dwebp $image -o $pngfile"
	dwebp $image -o $pngfile
	echo "convert $pngfile $jpegfile"
	convert $pngfile $jpegfile
done
