#!/bin/sh

file=screenshot-$(date +"%Y-%m-%d-%H-%M-%S")

echo file : $file
echo

if [ -n "$WAYLAND_DISPLAY" ]
then
	hyprshot -m window -o ~/racine/pictura/screenshot/hyprshot -f $file.jpg
elif [ -n "$DISPLAY" ]
then
	delay=$1
	shift
	scrot -d $delay -c -s "$@" ~/racine/pictura/screenshot/scrot/$file.png
fi
