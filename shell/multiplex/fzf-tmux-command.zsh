#!/usr/bin/env zsh

[[ $TERM = tmux* ]] || {
	echo "Not in tmux session"
	echo
	exit 0
}

export FZF_DEFAULT_OPTS='
	-i
	--exact
	--info=hidden
	--layout=reverse
	--scroll-off=5
	--tiebreak=index
	--bind=alt-space:toggle+down,shift-tab:toggle+down
	--bind=alt-a:toggle-all
	--bind=ctrl-s:toggle-sort
	--bind=ctrl-u:end-of-line+unix-line-discard
	--bind=home:first,end:last
	--color=bw
	'

commande=$(tmux list-commands | fzf | cut -d " " -f 1)

(( $#commande == 0 )) && exit 0

echo "$commande" >>! ~/racine/hist/fzf/tmux-history

tmux $commande
