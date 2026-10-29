#!/usr/bin/env zsh

can_suspend=$(can-suspend.sh)
code=$?

[ $code -eq 0 ] || {
	notify-send "Suspend is blocked" "$can_suspend"
	exit $code
}

confirmation=(
	Non
	"Faut voir"
	Oui
)

certain=$(print -l $confirmation | rofi -dmenu -i -p "really suspend ? ")

echo certain : $certain
echo

[ $certain = Oui ] || {
	echo Doing nothing
	echo
	exit 0
}

sync

systemctl suspend
