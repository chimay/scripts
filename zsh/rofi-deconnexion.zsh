#! /usr/bin/env zsh

menu=(Non Peut-être Oui)

# Rofi dmenu {{{1

choix=$(print -l $menu | rofi -dmenu -p "Déconnexion ? " -i)

# }}}1

[ $choix = Oui ] || exit 0

winman=$(wmctrl -m | head -n 1 | cut -d ' ' -f 2)

if [ $winman = i3 ]
then
	i3-msg exit
elif [ $winman = bspwm ]
then
	bspc quit
fi
