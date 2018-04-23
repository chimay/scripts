#!/usr/bin/env /bin/zsh

menu=( \
	"Charger une session" \
	"Annuler" \
)

choix=$( \
	print -l $menu | \
	fzf --cycle --hscroll-off=100 --color=bw \
)

case $choix in

	"Charger une session")
		exec ~/racine/shell/dialog/fzf-tmux-session.zsh
		;;
	"Annuler")
		exit 0
		;;
esac
