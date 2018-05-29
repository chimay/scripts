#! /usr/bin/env zsh

setopt extended_glob

menu=(
	"0 Applications"
	"1 Applications par catégories"
	"2 Terminaux"
	"3 Outils"
	"4 Internet"
	"5 Recherche Web"
	"6 Signets"
	"7 Presse-papier"
	"8 Bureaux"
	"9 Fenêtres"
	"a Fermer une fenêtre"
	"b Combinaison"
	"c Éteindre"
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

	[0-9a-z]##" Applications")
		~/racine/shell/dialog/rofi-run.zsh & disown
		;;
	[0-9a-z]##" Applications par catégories")
		xfce4-appfinder & disown
		;;
	[0-9a-z]##" Terminaux")
		~/racine/shell/dialog/rofi-terminal.zsh & disown
		;;
	[0-9a-z]##" Outils")
		~/racine/shell/dialog/rofi-outils.zsh & disown
		;;
	[0-9a-z]##" Internet")
		~/racine/shell/dialog/rofi-internet.zsh & disown
		;;
	[0-9a-z]##" Recherche Web")
		~/racine/shell/dialog/rofi-surfraw.zsh & disown
		;;
	[0-9a-z]##" Signets")
		~/racine/shell/dialog/rofi-buku.zsh & disown
		;;
	[0-9a-z]##" Presse-papier")
		~/racine/shell/dialog/rofi-greenclip.zsh & disown
		;;
	[0-9a-z]##" Bureaux")
		~/racine/shell/dialog/rofi-bureaux.zsh & disown
		;;
	[0-9a-z]##" Fenêtres")
		~/racine/shell/dialog/rofi-fenetres.zsh & disown
		;;
	[0-9a-z]##" Combinaison")
		~/racine/shell/dialog/rofi-combi.zsh & disown
		;;
	[0-9a-z]##" Fermer une fenêtre")
		~/racine/shell/dialog/rofi-fermer.zsh & disown
		;;
	[0-9a-z]##" Éteindre")
		~/racine/shell/dialog/rofi-eteindre.zsh & disown
		;;
esac
