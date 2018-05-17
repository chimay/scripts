#! /usr/bin/env zsh

setopt extended_glob

menu=(
	"0 Firefox"
	"1 Qutebrowser"
	"2 Recherche Web"
	"3 Signets"
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
	[0-9]##" Firefox")
		firefox &!
		disown
		;;
	[0-9]##" Qutebrowser")
		qutebrowser &!
		disown
		;;
	[0-9]##" Recherche Web")
		~/racine/shell/dialog/rofi-surfraw.zsh &
		disown
		;;
	[0-9]##" Signets")
		~/racine/shell/dialog/rofi-signets.zsh &
		disown
		;;
esac
