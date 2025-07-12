#! /usr/bin/env zsh

menu=(Annuler Veille Hibernation Éteindre)

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

# Rofi dmenu {{{1

choix=$(print -l $menu | rofi -dmenu -p "que faire " -i)

# }}}1

# Affichage {{{1

echo choix : $choix
echo

# }}}1

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

[[ $choix = Hibernation ]] && {

	echo "Non implémenté"
	echo

	zenity --info --no-wrap --text "Il fait trop chaud pour hiberner."
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
