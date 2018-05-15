
#! /usr/bin/env zsh

menu=("0 Principal" "1 Auxiliaire" "2 Navigation" "3 Graphique")

# Rofi dmenu {{{1

choix=$(rofi -dmenu -p "nouveau nom pour le bureau ? " -i -theme ~/racine/config/terminal/rofi/theme.rasi)

# }}}1

# Affichage {{{1

echo choix : $choix
echo

# }}}1

# i3-msg {{{1

i3-msg rename workspace to $choix

# }}}1
