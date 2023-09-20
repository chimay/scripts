#! /usr/bin/env zsh

argumen=($@)
menu=(Non Peut-être Oui)
prompt="Lancer $=argumen ? "

# Rofi dmenu {{{1

choix=$(print -l $menu | rofi -dmenu -p "$prompt" -i)

# }}}1

[ $choix = Oui ] && $=argumen
