#! /usr/bin/env zsh

menu=("0 Principal" "1 Auxiliaire" "2 Navigation" "3 Graphique")

# Rofi dmenu {{{1

choix=($(rofi -dmenu -p "déplacer vers le le bureau ? " -i))

choix=${(j: :)choix}

# }}}1

# Affichage {{{1

echo choix : $choix
echo

# }}}1

# i3-msg {{{1

i3-msg move workspace \"$choix\"

# }}}1
