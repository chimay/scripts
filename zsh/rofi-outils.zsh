#! /usr/bin/env zsh

setopt extended_glob

menu=(
	"0 Vifm (File manager)"
	"1 Ranger (File manager)"
	"2 W3m (Web browser)"
	"3 Elinks (Web browser)"
	"4 Cmus (Music)"
	"5 Ncmpcpp (Music)"
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
	[0-9a-z]##" Vifm"*)
		urxvtc -e vifm & disown
		;;
	[0-9a-z]##" Ranger"*)
		urxvtc -e ranger & disown
		;;
	[0-9a-z]##" W3m"*)
		urxvtc -e w3m & disown
		;;
	[0-9a-z]##" Elinks"*)
		urxvtc -e elinks & disown
		;;
	[0-9a-z]##" Cmus"*)
		urxvtc -e cmus & disown
		;;
	[0-9a-z]##" Ncmpcpp"*)
		urxvtc -e ncmpcpp & disown
		;;
esac
