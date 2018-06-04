#! /usr/bin/env zsh

fichier=~/racine/config/windenv/i3/bureaux

menu=(${(f)"$(<$fichier)"})

menu+=(${(f)"$(wmctrl -d | cut -d' '  -f12- | sed 's/^ //')"})

menu=(${(u)menu})

# Rofi dmenu {{{1

choix=$(print -l $menu | rofi -dmenu -p "aller vers le bureau " -i)

# }}}1

# Affichage {{{1

echo choix : $choix
echo

# }}}1

# i3-msg {{{1

i3-msg workspace $choix

# }}}1
