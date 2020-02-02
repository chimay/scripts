#! /usr/bin/env zsh

menu=(Annuler Veille Hibernation Éteindre)

confirmation=(
	Non
	"Faut voir"
	Oui
)

# Rofi dmenu {{{1

choix=$(print -l $menu | rofi -dmenu -p "que faire " -i)

# }}}1

# Affichage {{{1

# Empeche l’exécution de la suite dans polybar
# echo choix : $choix
# echo

# }}}1

sync

[[ $choix = Veille ]] && {

	certain=$(print -l $confirmation | rofi -dmenu -i -p "$choix ? ")

	[[ $certain = Oui ]] && {

		echo "systemctl suspend"
		echo

		systemctl suspend
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

		echo "systemctl poweroff"
		echo

		systemctl poweroff
	}
}

exit 0
