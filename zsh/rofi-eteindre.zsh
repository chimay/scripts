#! /usr/bin/env zsh

# Ajouter des NOPASSWD dans /etc/sudoers pour :
#
# pm-suspend
# pm-hibernate
# poweroff

menu=(Veille Hibernation Eteindre)

confirmation=(Non \
	"J’hésite" \
	"Y a du pour et du contre" \
	"Aujourd’hui non, on verra demain" \
	Oui)

# Rofi dmenu {{{1

choix=$(for element in $menu
do
	echo $element

done | rofi -dmenu -i -theme ~/racine/config/terminal/rofi/theme.rasi)

# }}}1

# Affichage {{{1

echo choix : $choix
echo

# }}}1

sync

[[ $choix = Veille ]] && {

	certain=$(for element in $confirmation
	do
		echo $element

	done | rofi -dmenu -i -theme ~/racine/config/terminal/rofi/theme.rasi)

	[[ $certain = Oui ]] && {

		echo "sudo pm-suspend"
		echo

		sudo pm-suspend
	}
}

[[ $choix = Hibernation ]] && {

	echo "Non implémenté"
	echo
}

[[ $choix = Eteindre ]] && {

	certain=$(for element in $confirmation
	do
		echo $element

	done | rofi -dmenu -i -theme ~/racine/config/terminal/rofi/theme.rasi)

	[[ $certain = Oui ]] && {

		echo "sudo poweroff"
		echo

		sudo poweroff
	}
}

exit 0
