#!/usr/bin/env /bin/zsh

cd ~/racine/config/multiplex/tmux/session

fichier=$( \
	print -l * | \
	grep -v Grenier | \
	fzf --cycle --hscroll-off=100 --color=bw \
)

(( $#fichier == 0 )) && exit 0

tmux source-file $fichier
