#!/usr/bin/env zsh

[[ $TERM = tmux* ]] || {

	echo "Not in tmux session"
	echo

	exit 0
}

choices=(
	'zsh -l'
	'fish -l'
	elvish
	xonsh
	'ed -v -p " ed : "'
	'clifm --no-color'
	lftp
	)

command=$(print -l $choices | fzf --prompt='tmux> ')

(( $#command == 0 )) && exit 0

tmux new-window $command
