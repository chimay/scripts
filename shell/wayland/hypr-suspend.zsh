#!/usr/bin/env zsh

can_suspend=$(can-suspend.sh)
code=$?

[ $code -eq 0 ] || {
	notify-send "Suspend is blocked" "$can_suspend"
	exit $code
}

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

certain=$(print -l $confirmation | rofi -dmenu -i -p "really suspend ? ")

echo certain : $certain
echo

[ $certain = yes ] || {
	echo Doing nothing
	echo
	exit 0
}

sync

$powerctl suspend

autowake.zsh &>>! ~/log/autowake.log
