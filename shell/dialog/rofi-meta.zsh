#! /usr/bin/env zsh

setopt extended_glob

menu=(
	"! Applications"
	"= Applications par catégories"
	"$ Terminaux"
	": Outils"
	"@ Internet"
	"/ Recherche Web"
	"£ Signets"
	"ç Presse-papier"
	"§ Bureaux"
	"^ Fenêtres"
	"X Fermer une fenêtre"
	"! Disposition du clavier"
	"µ Combinaison"
	"IO Éteindre"
)

# Rofi in dmenu mode {{{1

choix=$(print -l $menu | rofi -dmenu -p "Menu " -i)

# Affichage {{{1

echo choix : $choix
echo

case $choix in
	"! Applications")
		~/racine/shell/dialog/rofi-run.zsh & disown
		;;
	"= Applications par catégories")
		xfce4-appfinder & disown
		;;
	"$ Terminaux")
		~/racine/shell/dialog/rofi-terminal.zsh & disown
		;;
	": Outils")
		~/racine/shell/dialog/rofi-outils.zsh & disown
		;;
	"@ Internet")
		~/racine/shell/dialog/rofi-internet.zsh & disown
		;;
	"/ Recherche Web")
		~/racine/shell/dialog/rofi-surfraw.zsh & disown
		;;
	"£ Signets")
		~/racine/shell/dialog/rofi-buku.zsh & disown
		;;
	"ç Presse-papier")
		#~/racine/shell/dialog/rofi-greenclip.zsh & disown
		~/racine/shell/dialog/rofi-clipmenu.zsh & disown
		;;
	"§ Bureaux")
		~/racine/shell/dialog/rofi-bureau.zsh & disown
		;;
	"^ Fenêtres")
		~/racine/shell/dialog/rofi-fenetres.zsh & disown
		;;
	"µ Combinaison")
		~/racine/shell/dialog/rofi-combi.zsh & disown
		;;
	"X Fermer une fenêtre")
		~/racine/shell/dialog/rofi-fermer.zsh & disown
		;;
	"! Disposition du clavier")
		~/racine/shell/dialog/rofi-clavier.zsh & disown
		;;
	"IO Éteindre")
		~/racine/shell/dialog/rofi-eteindre.zsh & disown
		;;
esac
