#!/usr/bin/env zsh

if which systemctl
then
	powerctl=systemctl
else
	powerctl=loginctl
fi

confirmation=(
	no
	"let me think"
	yes
)

certain=$(print -l $confirmation | rofi -dmenu -i -p "really poweroff ? ")

echo certain : $certain
echo

[ $certain = yes ] || {
	echo Doing nothing
	echo
	exit 0
}

hypr-autostop.zsh

sync

$powerctl poweroff
