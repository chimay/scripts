#! /usr/bin/env zsh

setopt extended_glob

menu=(
	"/ Recherche Web -> Qutebrowser"
	"? Recherche Web -> Firefox"
	"+ Signets -> Qutebrowser"
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
	[0-9]##" Recherche Web -> Qutebrowser")
		~/racine/shell/dialog/rofi-surfraw.zsh & disown
		;;
	[0-9]##" Signets -> Qutebrowser")
		~/racine/shell/dialog/rofi-buku.zsh & disown
		;;
	[0-9]##" Ouvrir Qutebrowser")
		qutebrowser & disown
		;;
	[0-9]##" Recherche Web -> Firefox")
		~/racine/shell/dialog/rofi-surfraw.zsh firefox & disown
		;;
	[0-9]##" Signets -> Firefox")
		~/racine/shell/dialog/rofi-buku.zsh firefox & disown
		;;
	[0-9]##" Ouvrir Firefox")
		firefox & disown
		;;
esac
