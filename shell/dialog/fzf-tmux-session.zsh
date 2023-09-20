#!/usr/bin/env zsh

[[ $TERM = tmux* ]] || {

	echo "Not in tmux session"
	echo

	exit 0
}

cd ~/racine/config/multiplex/tmux/session

fichier=$(print -l * | grep -v Grenier | fzf --preview 'cat {}' --prompt='tmux> ')

(( $#fichier == 0 )) && exit 0

tmux source-file $fichier
