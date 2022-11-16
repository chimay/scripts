#!/usr/bin/env zsh

setopt extended_glob

for image in **/*.(jpg|JPG)
do
	webpfile=${image%.*}.webp
	echo "cwebp -q 75 $image -o $webpfile"
	cwebp -q 75 $image -o $webpfile
done
