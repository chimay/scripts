#! /usr/bin/env zsh

objectif=$(xdotool search --classname deroulant)

retour=$?

courante=$(xdotool getactivewindow)

if [ $#objectif -gt 0 -a $#courante -gt 0 -a $courante = $objectif ]
then
	i3-msg move scratchpad

elif (( retour == 0 ))
then
	xdotool windowactivate $objectif
else
	urxvtc -name deroulant -geometry 120x30 -e zsh -l
fi
