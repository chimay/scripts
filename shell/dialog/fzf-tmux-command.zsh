#!/usr/bin/env zsh

[[ $TERM = tmux* ]] || {

	echo "Not in tmux session"
	echo

	exit 0
}

commande=$(tmux list-commands | fzf | cut -d " " -f 1)

(( $#commande == 0 )) && exit 0

echo "$commande" >>! ~/racine/hist/fzf/tmux-history

if [ $# > 0 -a x$1 = x-s ]
then
	# add a space before the command
	# so that zsh does not record this in its history
	tmux send-keys " tmux $commande "
else
	tmux $commande
fi
