#!/usr/bin/env zsh

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

if [ $# > 0 -a x$1 = x-s ]
then
	tmux send-keys " tmux $commande "
else
	tmux $commande
fi
