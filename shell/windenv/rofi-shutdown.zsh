#! /usr/bin/env zsh

pgrep -f freetube >! ~/log/pgrep.log 2>&1 && {
	zenity --info --no-wrap --text "freetube is running, please stop it first"
	exit 1
}

pgrep -f helium >! ~/log/pgrep.log 2>&1 && {
	zenity --info --no-wrap --text "helium is running, please stop it first"
	exit 1
}

pgrep -f waterfox >! ~/log/pgrep.log 2>&1 && {
	zenity --info --no-wrap --text "waterfox is running, please stop it first"
	exit 1
}

menu=(Annuler Veille Hiberner Éteindre)

confirmation=(
	Non
	"Faut voir"
	Oui
)

if which systemctl
then
	powerctl=systemctl
else
	powerctl=loginctl
fi

choix=$(print -l $menu | rofi -dmenu -p "que faire " -i)

echo choix : $choix
echo

sync -f /
sync -f $HOME

[[ $choix = Veille ]] && {
	certain=$(print -l $confirmation | rofi -dmenu -i -p "$choix ? ")
	[[ $certain = Oui ]] && {
		echo "$powerctl suspend"
		echo
		$powerctl suspend
		autowake.zsh &>>! ~/log/autowake.log
	}
}

[[ $choix = Hiberner ]] && {
	if [[ $powerctl = systemctl ]]
	then
		echo "Not implemented"
		echo
		zenity --info --no-wrap --text "Il fait trop chaud pour hiberner."
	elif [[ $powerctl = loginctl ]]
	then
		certain=$(print -l $confirmation | rofi -dmenu -i -p "$choix ? ")
		[[ $certain = Oui ]] && {
			echo "$powerctl hibernate"
			echo
			$powerctl hibernate
		}
	fi
}

[[ $choix = Éteindre ]] && {
	certain=$(print -l $confirmation | rofi -dmenu -i -p "$choix ? ")
	[[ $certain = Oui ]] && {
		echo "$powerctl poweroff"
		echo
		$powerctl poweroff
	}
}

exit 0
