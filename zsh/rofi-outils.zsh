#! /usr/bin/env zsh

setopt extended_glob

menu=(
	": Gvim (Editor)"
	"; Neovim Qt (Editor)"
	"x Emacs (Editor)"
	"2 Vifm (File manager)"
	"3 Ranger (File manager)"
	"# Sc-im (Spreadsheet Calculator)"
	"+ Calcurse (Calendar & Tasks)"
	"ŧ Vit (Tasks)"
	"@ Nmtui (Connection Manager)"
	"< W3m (Web browser)"
	"> Elinks (Web browser)"
	"§ Neomutt (Mail)"
	"= Newsboat (Rss)"
	"µ Ncmpcpp (Music)"
	"£ Cmus (Music)"
)

# Rofi dmenu {{{1

choix=$(print -l $menu | rofi -dmenu -p "Menu " -i)

# }}}1

# Affichage {{{1

# Empeche l’exécution de la suite dans polybar
# echo choix : $choix
# echo

# }}}1

case $choix in
	": Gvim"*)
		~/racine/shell/run/lance-gvim.zsh & disown
		;;
	"; Neovim Qt"*)
		~/racine/shell/run/lance-neovim.zsh & disown
		;;
	"x Emacs"*)
		~/racine/shell/run/lance-emacs.zsh & disown
		;;
	"2 Vifm"*)
		urxvtc -e vifm & disown
		;;
	"3 Ranger"*)
		urxvtc -e ranger & disown
		;;
	"# Sc-im"*)
		urxvtc -e sc-im & disown
		;;
	"+ Calcurse"*)
		urxvtc -e calcurse & disown
		;;
	"ŧ Vit"*)
		urxvtc -e vit & disown
		;;
	"@ Nmtui"*)
		urxvtc -e nmtui & disown
		;;
	"< W3m"*)
		urxvtc -e w3m & disown
		;;
	"> Elinks"*)
		urxvtc -e elinks & disown
		;;
	"§ Neomutt"*)
		urxvtc -e neomutt & disown
		;;
	"= Newsboat"*)
		urxvtc -e newsboat -c ~/racine/index/newsboat/cache.db & disown
		;;
	"µ Ncmpcpp"*)
		urxvtc -e ncmpcpp & disown
		;;
	"£ Cmus"*)
		urxvtc -e cmus & disown
		;;
esac
