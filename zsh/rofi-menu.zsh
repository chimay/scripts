#! /usr/bin/env zsh

menu=(
	"Applications"
	"Bureaux"
	"Fenêtres"
	"Presse-papier"
	"Fermer ou Éteindre"
	"Combinaison"
)

# Rofi dmenu {{{1

choix=$(for element in $menu
do
	echo $element

done | rofi -dmenu -p "Choix ? " -i -theme ~/racine/config/terminal/rofi/theme.rasi)

# }}}1

# Affichage {{{1

echo choix : $choix
echo

# }}}1

case $choix in
	"Applications")
		~/racine/shell/dialog/rofi-run.zsh
		;;
	"Bureaux")
		~/racine/shell/dialog/rofi-bureaux.zsh
		;;
	"Fenêtres")
		~/racine/shell/dialog/rofi-fenetres.zsh
		;;
	"Presse-papier")
		~/racine/shell/dialog/rofi-greenclip.zsh
		;;
	"Fermer ou Éteindre")
		~/racine/shell/dialog/rofi-eteindre.zsh
		;;
	"Combinaison")
		~/racine/shell/dialog/rofi-combi.zsh
		;;
esac
