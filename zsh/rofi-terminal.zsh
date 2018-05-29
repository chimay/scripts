#! /usr/bin/env zsh

setopt extended_glob

menu=(
	"0 XTerm"
	"1 UXTerm"
	"2 URxvtc"
	"3 Tilix"
	"4 Tilix en mode quake"
	"5 Yakuake"
)

# Rofi dmenu {{{1

choix=$(for element in $menu
do
	echo $element

done | rofi -dmenu -p "Menu " -i)

# }}}1

# Affichage {{{1

echo choix : $choix
echo

# }}}1

case $choix in
	[0-9a-z]##" XTerm")
		xterm -e zsh -l & disown
		;;
	[0-9a-z]##" UXTerm")
		uxterm -e zsh -l & disown
		;;
	[0-9a-z]##" URxvtc")
		urxvtc -e zsh -l & disown
		;;
	[0-9a-z]##" Tilix")
		tilix -e zsh -l & disown
		;;
	[0-9a-z]##" Tilix en mode quake")
		tilix -q -e zsh -l & disown
		;;
	[0-9a-z]##" Yakuake")
		yakuake & disown
		;;
esac
