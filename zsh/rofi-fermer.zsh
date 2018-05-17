#! /usr/bin/env zsh

menu=(Annuler "Fermer la fenêtre courante" "Choisir une fenêtre à fermer")

# Rofi dmenu {{{1

choix=$(print -l $menu | rofi -dmenu -p "fermer " -i)

# }}}1

[[ $choix = "Fermer la fenêtre courante" ]] && {

	echo "i3-msg kill"
	echo

	i3-msg kill
}

[[ $choix = "Choisir une fenêtre à fermer" ]] && {

	echo "xkill"
	echo

	xkill
}
