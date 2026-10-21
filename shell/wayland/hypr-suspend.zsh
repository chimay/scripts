#!/usr/bin/env zsh

pgrep -f freetube && {
	notify-send "freetube is running" "please stop it before suspending"
	exit 0
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
