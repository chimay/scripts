#!/usr/bin/env /bin/zsh

fichier=~/racine/hist/fzf/tmux-history

sort $fichier | uniq >! $fichier.nouveau

mv -f $fichier.nouveau $fichier

commande=$( \
	cat $fichier | \
	fzf --cycle --reverse --hscroll-off=100 --color=bw \
)

(( $#commande == 0 )) && exit 0

tmux split-window -p 90
tmux send-keys -t .3 "$commande"
