#! /usr/bin/env zsh

menu=("Préparer le café" Fermer Veille Hibernation Eteindre)

confirmation=(Non \
	"J’hésite" \
	"Y a du pour et du contre" \
	"Aujourd’hui non, on verra demain" \
	Oui \
	"Quoique")

# Rofi dmenu {{{1

choix=$(for element in $menu
do
	echo $element

done | rofi -dmenu -p "que faire ? " -i -theme ~/racine/config/terminal/rofi/theme.rasi)

# }}}1

# Affichage {{{1

echo choix : $choix
echo

# }}}1

sync

[[ $choix = *café* ]] && {

	echo "Non implémenté"
	echo

	zenity --info --no-wrap --text "Dis tout de suite que j’ai une tête de cafetière ?"
}

[[ $choix = Fermer ]] && {

	echo "i3-msg kill"
	echo

	i3-msg kill
}

[[ $choix = Veille ]] && {

	certain=$(for element in $confirmation
	do
		echo $element

	done | rofi -dmenu -i -p "$choix ? " -theme ~/racine/config/terminal/rofi/theme.rasi)

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

[[ $choix = Eteindre ]] && {

	certain=$(for element in $confirmation
	do
		echo $element

	done | rofi -dmenu -i -p "$choix ? " -theme ~/racine/config/terminal/rofi/theme.rasi)

	[[ $certain = Oui ]] && {

		echo "systemctl poweroff"
		echo

		systemctl poweroff
	}
}

exit 0
