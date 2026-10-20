#!/usr/bin/env zsh

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
