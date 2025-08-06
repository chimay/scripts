#!/usr/bin/env zsh

setopt extended_glob

folder=${1:-.}

cd $folder

for image in **/*.(jpg|JPG)
do
	webpfile=${image%.*}.webp
	[ -f $webpfile ] && {
		echo $webpfile already exists
		echo
		continue
	}
	echo "cwebp -q 75 $image -o $webpfile"
	echo
	cwebp -q 75 $image -o $webpfile
done
