#! /usr/bin/env zsh

menu=(
	"Firefox"
	"Qutebrowser"
	"Recherche Web"
)

# Rofi dmenu {{{1

choix=$(for element in $menu
do
	echo $element

done | rofi -dmenu -p "Menu : " -i)

# }}}1

# Affichage {{{1

echo choix : $choix
echo

# }}}1

case $choix in
	"Firefox")
		firefox &!
		disown
		;;
	"Qutebrowser")
		qutebrowser &!
		disown
		;;
	"Recherche Web")
		~/racine/shell/dialog/rofi-surfraw.zsh &
		disown
		;;
esac
