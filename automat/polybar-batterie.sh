#!/usr/bin/env sh

# vim: set filetype=sh:

while true
do
	sortie=$(acpi -b | cut -d ' ' -f 3-4 | sed 's/,//g')
	echo Bat $sortie
	sleep 60
done
