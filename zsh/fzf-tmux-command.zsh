#!/usr/bin/env /bin/zsh

choix=$( \
	tmux list-commands | \
	fzf \
	--history=$HOME/racine/hist/fzf/tmux-command \
	--history-size=3000 \
	--cycle --reverse --hscroll-off=100 --color=bw \
)

commande=$( \
	echo $choix | \
	awk '{print $1}'
)

(( $#commande == 0 )) && exit 0

echo "tmux $commande" >>! ~/racine/hist/fzf/tmux-history

tmux split-window -p 90
tmux send-keys -t .3 "tmux $commande"
