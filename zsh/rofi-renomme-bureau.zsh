#! /usr/bin/env zsh

menu=()

#fichier=~/racine/config/windenv/i3/bureaux
#menu+=(${(f)"$(<$fichier)"})

menu+=(${(f)"$(wmctrl -d | cut -d' '  -f12- | sed 's/^ //')"})

menu=(${(u)menu})

# Rofi dmenu {{{1

choix=$(print -l $menu | rofi -dmenu -p "nouveau nom pour le bureau " -i)

choix=${(j: :)choix}

# }}}1

# Affichage {{{1

# Empeche l’exécution de la suite dans polybar
# echo choix : $choix
# echo

# }}}1

# Window Manager {{{1

winman=$(wmctrl -m | head -n 1 | cut -d ' ' -f 2)

if [ $winman = i3 ]
then
	i3-msg rename workspace to \"$choix\"
elif [ $winman = bspwm ]
then
	# todo
fi

# }}}1
