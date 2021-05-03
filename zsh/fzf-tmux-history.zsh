#!/usr/bin/env zsh

[[ $TERM = tmux* ]] || {

	echo "Not in tmux session"
	echo

	exit 0
}

fichier=~/racine/hist/fzf/tmux-history

sort $fichier | uniq | sponge $fichier

commande=$(cat $fichier | fzf)

(( $#commande == 0 )) && exit 0

if [ $# > 0 -a x$1 = x-s ]
then
	tmux send-keys " tmux $commande "
else
	tmux $commande
fi
