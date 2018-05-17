#! /usr/bin/env zsh

setopt extended_glob

menu=(
	"0 Applications"
	"1 Bureaux"
	"2 Fenêtres"
	"3 Presse-papier"
	"4 Recherche Web"
	"5 Signets"
	"6 Internet"
	"7 Combinaison"
	"8 Fermer une fenêtre"
	"9 Éteindre"
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
	[0-9]##" Applications")
		~/racine/shell/dialog/rofi-run.zsh
		;;
	[0-9]##" Bureaux")
		~/racine/shell/dialog/rofi-bureaux.zsh
		;;
	[0-9]##" Fenêtres")
		~/racine/shell/dialog/rofi-fenetres.zsh
		;;
	[0-9]##" Presse-papier")
		~/racine/shell/dialog/rofi-greenclip.zsh
		;;
	[0-9]##" Recherche Web")
		~/racine/shell/dialog/rofi-surfraw.zsh &
		disown
		;;
	[0-9]##" Signets")
		~/racine/shell/dialog/rofi-buku.zsh &
		disown
		;;
	[0-9]##" Internet")
		~/racine/shell/dialog/rofi-internet.zsh &
		disown
		;;
	[0-9]##" Combinaison")
		~/racine/shell/dialog/rofi-combi.zsh
		;;
	[0-9]##" Fermer une fenêtre")
		~/racine/shell/dialog/rofi-fermer.zsh
		;;
	[0-9]##" Éteindre")
		~/racine/shell/dialog/rofi-eteindre.zsh
		;;
esac