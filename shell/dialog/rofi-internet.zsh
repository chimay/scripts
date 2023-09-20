#! /usr/bin/env zsh

setopt extended_glob

menu=(
	"/ Recherche Web -> Qutebrowser"
	"? Recherche Web -> Firefox"
	"£ Signets -> Qutebrowser"
	"@ Signets -> Firefox"
	"< Ouvrir Qutebrowser"
	"> Ouvrir Firefox"
)

# Rofi dmenu {{{1

choix=$(print -l $menu | rofi -dmenu -p "Menu : " -i)

# }}}1

# Affichage {{{1

echo choix : $choix
echo

# }}}1

case $choix in
	"/ Recherche Web -> Qutebrowser")
		~/racine/shell/dialog/rofi-surfraw.zsh & disown
		;;
	"? Recherche Web -> Firefox")
		~/racine/shell/dialog/rofi-surfraw.zsh firefox & disown
		;;
	"£ Signets -> Qutebrowser")
		~/racine/shell/dialog/rofi-buku.zsh & disown
		;;
	"@ Signets -> Firefox")
		~/racine/shell/dialog/rofi-buku.zsh firefox & disown
		;;
	"< Ouvrir Qutebrowser")
		qutebrowser & disown
		;;
	"> Ouvrir Firefox")
		firefox & disown
		;;
esac
