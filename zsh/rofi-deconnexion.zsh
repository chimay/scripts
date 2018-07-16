#! /usr/bin/env zsh

menu=(Non Peut-être Oui)

# Rofi dmenu {{{1

choix=$(print -l $menu | rofi -dmenu -p "Déconnexion ? " -i)

# }}}1

[ $choix = Oui ] && i3-msg exit
