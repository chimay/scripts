#! /usr/bin/env zsh

setopt extended_glob

menu=(
	"< Aller vers le bureau"
	"> Déplacer la fenêtre vers le bureau"
	"= Renommer le bureau"
)

# Rofi dmenu {{{1

choix=$(print -l $menu | rofi -dmenu -p "Menu : " -i)

# }}}1

# Affichage {{{1

echo choix : $choix
echo

# }}}1

case $choix in
	"< Aller vers le bureau")
		~/racine/shell/dialog/rofi-aller-vers-bureau.zsh & disown
		;;
	"> Déplacer la fenêtre vers le bureau")
		~/racine/shell/dialog/rofi-deplace-vers-bureau.zsh & disown
		;;
	"= Renommer le bureau")
		~/racine/shell/dialog/rofi-renomme-bureau.zsh & disown
		;;
esac

