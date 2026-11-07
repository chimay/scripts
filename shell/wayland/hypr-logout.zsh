#!/usr/bin/env zsh

# confirmation {{{1

if pgrep -af noctalia
then
	confirmation=(
		no
		"let me think"
		yes
	)
	certain=$(print -l $confirmation | rofi -dmenu -i -p "really logout ? ")
	echo certain : $certain
	echo
	[ $certain = yes ] || {
		echo Doing nothing
		echo
		exit 0
	}
fi

# logout {{{1

hypr-autostop.zsh

sync

uwsm stop
code=$?

[ $code -eq 0 ] || hyprctl dispatch 'hl.dsp.exit()'
code=$?

[ $code -eq 0 ] || hyprshutdown
