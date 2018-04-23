#!/usr/bin/env /bin/zsh

[[ $TERM = tmux* ]] || {

	echo "Not in tmux session"
	echo

	exit 0
}

fichier=~/racine/hist/fzf/tmux-history

sort $fichier | uniq >! $fichier.nouveau

mv -f $fichier.nouveau $fichier

commande=$( \
	cat $fichier | \
	fzf --cycle --hscroll-off=100 --color=bw --prompt='tmux> ' \
)

(( $#commande == 0 )) && exit 0

tmux send-keys "$commande "
