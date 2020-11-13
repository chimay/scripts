#!/usr/bin/env zsh

[[ $TERM = tmux* ]] || {

	echo "Not in tmux session"
	echo

	exit 0
}

commande=$(tmux list-commands | sk-tmux | cut -d " " -f 1)

(( $#commande == 0 )) && exit 0

echo "$commande" >>! ~/racine/hist/fzf/tmux-history

if [ $# > 0 -a x$1 = x-s ]
then
	tmux send-keys " tmux $commande "
else
	tmux $commande
fi
