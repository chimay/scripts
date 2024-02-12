#!/usr/bin/env zsh

emulate -R zsh
setopt local_options
setopt warn_create_global
setopt null_glob
zmodload zsh/regex

layout=$(\
	zenity \
	--width=600 \
	--height=600 \
	--title "Keyboard layout" \
	--list --radiolist \
	--column "Select" --column "Menu Item" \
	FALSE "custom, with super and hyper" \
	FALSE "belgian" \
	FALSE "french" \
	FALSE "usa" \
)

case $layout in
	 custom*)
		 setxkbmap be
		 xmodmap ~/racine/config/windenv/xmodmap/belge-meta-super-hyper
		;;
	 belgian)
		setxkbmap be
		;;
	 french)
		setxkbmap fr
		;;
	 usa)
		setxkbmap us
		;;
	 *)
		exit 0
		;;
esac

zenity --info --text="layout changed to $layout"
