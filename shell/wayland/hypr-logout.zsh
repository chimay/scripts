#!/usr/bin/env zsh

# confirmation {{{1

if pgrep -af noctalia
then
	confirmation=(
		Non
		"Faut voir"
		Oui
	)
	certain=$(print -l $confirmation | rofi -dmenu -i -p "really logout ? ")
	echo certain : $certain
	echo
	[ $certain = Oui ] || {
		echo Doing nothing
		echo
		exit 0
	}
fi

# logout {{{1

hypr-autostop.zsh

sync

uwsm stop

# -- other solutions, not recommended

#hyprctl dispatch 'hl.dsp.exit()'

#hyprshutdown
