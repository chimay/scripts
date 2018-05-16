#! /usr/bin/env zsh

menu=("0 Principal" "1 Auxiliaire" "2 Navigation" "3 Graphique")

menu+=(${(f)"$(wmctrl -d | cut -d' '  -f12- | sed 's/^ //')"})

menu=(${(u)menu})

# Rofi dmenu {{{1

choix=$(for element in $menu
do
	echo $element

done | rofi -dmenu -p "bureau ? " -i

# }}}1

# Affichage {{{1

echo choix : $choix
echo

# }}}1

# i3-msg {{{1

i3-msg workspace $choix

# }}}1
