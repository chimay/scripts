#! /usr/bin/env zsh

menu=(Annuler "Fermer la fenêtre courante" "Choisir une fenêtre à fermer")

# Rofi dmenu {{{1

choix=$(print -l $menu | rofi -dmenu -p "fermer " -i)

# }}}1

[[ $choix = "Fermer la fenêtre courante" ]] && {

winman=$(wmctrl -m | head -n 1 | cut -d ' ' -f 2)

if [ $winman = i3 ]
then
	i3-msg kill
elif [ $winman = bspwm ]
then
	bspc node -c
fi

}

[[ $choix = "Choisir une fenêtre à fermer" ]] && {

	echo "xkill"
	echo

	xkill
}
