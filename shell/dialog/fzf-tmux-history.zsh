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
