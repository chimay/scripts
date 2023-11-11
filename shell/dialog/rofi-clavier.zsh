#! /usr/bin/env zsh

setopt extended_glob

menu=(
	"Personnel (hyper = menu, caps & esc inversés)"
	"Belge"
	"Français"
	"Américain"
)

choix=$(print -l $menu | rofi -dmenu -p "Disposition du clavier " -i)

case $choix in
	*Personnel*)
		setxkbmap be
		xmodmap ~/racine/config/windenv/xmodmap/belge-meta-super-hyper
		;;
	*Belge*)
		setxkbmap be
		;;
	*Français*)
		setxkbmap fr
		;;
	*Américain*)
		setxkbmap us
		;;
esac
