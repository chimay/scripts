#! /usr/bin/env zsh

setopt extended_glob

menu=(
	": Gvim (Editor)"
	"; Neovim Qt (Editor)"
	"x Emacs (Editor)"
	"§ Vifm (File manager)"
	"3 Ranger (File manager)"
	"# Sc-im (Spreadsheet Calculator)"
	"+ Calcurse (Calendar and Tasks)"
	"& Abook (adress book)"
	"ŧ Vit (Tasks)"
	"$ Lazygit (Git TUI)"
	"@ Nmtui (Connection Manager)"
	"< W3m (Web browser)"
	"> Elinks (Web browser)"
	"µ Neomutt (Mail)"
	"µ Newsboat (Rss)"
	"£ Ncmpcpp (Music)"
	"£ Cmus (Music)"
	"£ Mocp (Music)"
)

# Rofi dmenu {{{1

choix=$(print -l $menu | rofi -dmenu -p "Menu " -i)

# }}}1

# Affichage {{{1

echo choix : $choix
echo

# }}}1

case $choix in
	": Gvim"*)
		~/racine/shell/run/run-gvim.zsh & disown
		;;
	"; Neovim Qt"*)
		~/racine/shell/run/run-neovim.zsh & disown
		;;
	"x Emacs"*)
		~/racine/shell/run/run-emacs.zsh & disown
		;;
	"§ Vifm"*)
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
	"& Abook"*)
		urxvtc -e abook & disown
		;;
	"ŧ Vit"*)
		urxvtc -e vit & disown
		;;
	"$ Lazygit"*)
		urxvtc -e lazygit & disown
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
	"µ Neomutt"*)
		urxvtc -e neomutt & disown
		;;
	"µ Newsboat"*)
		urxvtc -e newsboat -c ~/racine/index/newsboat/cache.db & disown
		;;
	"£ Ncmpcpp"*)
		urxvtc -e ncmpcpp & disown
		;;
	"£ Cmus"*)
		urxvtc -e cmus & disown
		;;
	"£ Mocp"*)
		urxvtc -e mocp & disown
		;;
esac
