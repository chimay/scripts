#!/usr/bin/env /bin/zsh

[[ $TERM = tmux* ]] || {

	echo "Not in tmux session"
	echo

	exit 0
}

choix=$( \
	tmux list-commands | \
	fzf \
	--history=$HOME/racine/hist/fzf/tmux-command \
	--history-size=3000 \
	--cycle --hscroll-off=100 --color=bw \
	--prompt='tmux> ' \
)

commande=$( \
	echo $choix | \
	awk '{print $1}'
)

(( $#commande == 0 )) && exit 0

echo "tmux $commande" >>! ~/racine/hist/fzf/tmux-history

tmux send-keys "tmux $commande "
