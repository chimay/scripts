#!/usr/bin/env /bin/zsh

# vim: set filetype=zsh:

bspc subscribe node_add | while read ligne
do
	desktop_windows=($(bspc query -N -n .window -d focused))
	print -l $desktop_windows
	echo
	if [ $#desktop_windows -eq 2 ]
	then
		echo "Swapping"
		echo
		bspwm-swap.sh
	fi
done &
