#! /usr/bin/env zsh

menu=("0 Principal" "1 Auxiliaire" "2 Navigation" "3 Graphique")

menu+=(${(f)"$(wmctrl -d | cut -d' '  -f12- | sed 's/^ //')"})

menu=(${(u)menu})

# Rofi dmenu {{{1

choix=$(print -l $menu | rofi -dmenu -p "nouveau nom pour le bureau " -i)

choix=${(j: :)choix}

# }}}1

# Affichage {{{1

echo choix : $choix
echo

# }}}1

# i3-msg {{{1

i3-msg rename workspace to \"$choix\"

# }}}1
