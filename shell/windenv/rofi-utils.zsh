#! /usr/bin/env zsh

setopt extended_glob

source ~/racine/config/shell/zsh/zprofile

menu=(
	": gvim (editor)"
	"; neovim qt (editor)"
	", kak (editor)"
	", helix (editor)"
	"x emacs (editor)"
	"§ vifm (file manager)"
	"3 ranger (file manager)"
	"# sc-im (spreadsheet calculator)"
	"+ calcurse (calendar and tasks)"
	"& abook (adress book)"
	"$ lazygit (git tui)"
	"@ nmtui (connection manager)"
	"< w3m (web browser)"
	"µ neomutt (mail)"
	"µ aerc (mail)"
	"  slrn (usenet)"
	"µ newsboat (rss)"
	"£ ncmpcpp (music)"
	"£ cmus (music)"
	"£ mocp (music)"
)

# Rofi dmenu {{{1

choix=$(print -l $menu | rofi -dmenu -p "Menu " -i)

# }}}1

# Affichage {{{1

echo choix : $choix
echo

# }}}1

case $choix in
	": gvim"*)
		run-gvim.sh & disown
		;;
	"; neovim qt"*)
		run-neovim.sh & disown
		;;
	", kak"*)
		urxvtc -e kak & disown
		;;
	", helix"*)
		urxvtc -e helix & disown
		;;
	"x emacs"*)
		run-emacs.sh & disown
		;;
	"§ vifm"*)
		urxvtc -e vifm & disown
		;;
	"3 ranger"*)
		urxvtc -e ranger & disown
		;;
	"# sc-im"*)
		urxvtc -e sc-im & disown
		;;
	"+ calcurse"*)
		urxvtc -e calcurse & disown
		;;
	"& abook"*)
		urxvtc -e abook & disown
		;;
	"$ lazygit"*)
		urxvtc -e lazygit & disown
		;;
	"@ nmtui"*)
		urxvtc -e nmtui & disown
		;;
	"< w3m"*)
		urxvtc -e w3m & disown
		;;
	"µ neomutt"*)
		urxvtc -e neomutt & disown
		;;
	"µ aerc"*)
		urxvtc -e aerc & disown
		;;
	"µ newsboat"*)
		urxvtc -e newsboat -c ~/racine/index/newsboat/cache.db & disown
		;;
	"£ ncmpcpp"*)
		urxvtc -e ncmpcpp & disown
		;;
	"£ cmus"*)
		urxvtc -e cmus & disown
		;;
	"£ mocp"*)
		urxvtc -e mocp & disown
		;;
esac
