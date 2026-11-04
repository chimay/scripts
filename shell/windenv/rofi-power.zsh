#! /usr/bin/env zsh

menu=(cancel suspend hibernate poweroff)

confirmation=(
	no
	"let me think"
	yes
)

if which systemctl
then
	powerctl=systemctl
else
	powerctl=loginctl
fi

choix=$(print -l $menu | rofi -dmenu -p "choice " -i)

echo choix : $choix
echo

sync

[[ $choix = suspend ]] && {
	can_suspend=$(can-suspend.sh)
	code=$?
	[ $code -eq 0 ] || {
		notify-send "Suspend is blocked" "$can_suspend"
		exit $code
	}
	certain=$(print -l $confirmation | rofi -dmenu -i -p "$choix ? ")
	[[ $certain = Oui ]] && {
		echo "$powerctl suspend"
		echo
		sleep 1
		$powerctl suspend
		autowake.zsh &>>! ~/log/autowake.log
	}
}

[[ $choix = hibernate ]] && {
	if [[ $HOST = universe ]]
	then
		echo "not supported"
		echo
		zenity --info --no-wrap --text "too hot to hibernate"
	else
		certain=$(print -l $confirmation | rofi -dmenu -i -p "$choix ? ")
		[[ $certain = Oui ]] && {
			echo "$powerctl hibernate"
			echo
			$powerctl hibernate
		}
	fi
}

[[ $choix = poweroff ]] && {
	certain=$(print -l $confirmation | rofi -dmenu -i -p "$choix ? ")
	[[ $certain = Oui ]] && {
		echo "$powerctl poweroff"
		echo
		$powerctl poweroff
	}
}

exit 0
