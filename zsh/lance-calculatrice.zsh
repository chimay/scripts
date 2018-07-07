#! /usr/bin/env zsh

objectif=$(xdotool search --classname calculatrice)

retour=$?

courante=$(xdotool getactivewindow)

if [ $#objectif -gt 0 -a $#courante -gt 0 -a $courante = $objectif ]
then
	i3-msg move scratchpad

elif (( retour == 0 ))
then
	xdotool windowactivate $objectif
else
	urxvtc -name calculatrice -geometry 120x30 -fn "xft:monospace:size=12" -e calc
fi
