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
		~/racine/shell/windenv/rofi-run.zsh & disown
		;;
	"= Applications par catégories")
		xfce4-appfinder & disown
		;;
	"$ Terminaux")
		~/racine/shell/windenv/rofi-terminal.zsh & disown
		;;
	": Outils")
		~/racine/shell/windenv/rofi-utils.zsh & disown
		;;
	"@ Internet")
		~/racine/shell/windenv/rofi-internet.zsh & disown
		;;
	"/ Recherche Web")
		~/racine/shell/windenv/rofi-surfraw.zsh & disown
		;;
	"£ Signets")
		~/racine/shell/windenv/rofi-buku.zsh & disown
		;;
	"ç Presse-papier")
		#~/racine/shell/windenv/rofi-greenclip.zsh & disown
		~/racine/shell/windenv/rofi-clipmenu.zsh & disown
		;;
	"§ Bureaux")
		~/racine/shell/windenv/rofi-desktop.zsh & disown
		;;
	"^ Fenêtres")
		~/racine/shell/windenv/rofi-windows.zsh & disown
		;;
	"µ Combinaison")
		~/racine/shell/windenv/rofi-combi.zsh & disown
		;;
	"X Fermer une fenêtre")
		~/racine/shell/windenv/rofi-close-window.zsh & disown
		;;
	"! Disposition du clavier")
		~/racine/shell/windenv/rofi-keyboard.zsh & disown
		;;
	"IO Éteindre")
		~/racine/shell/windenv/rofi-shutdown.zsh & disown
		;;
esac
