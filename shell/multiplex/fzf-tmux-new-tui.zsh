#!/usr/bin/env zsh

[[ $TERM = tmux* ]] || {

	echo "Not in tmux session"
	echo

	exit 0
}

choices=(
	vim
	nvim
	'emacs -nw -q -l ~/racine/config/edit/emacs/leger.el'
	vidir
	edir
	vifm
	htop
	bpytop
	w3m
	lazygit
	sc-im
	elinks
	run-neomutt.zsh
	'newsboat -c ~/racine/index/newsboat/cache.db'
	aria2p
	abook
	calcurse
	'alsamixer -c 0'
	pulsemixer
	ncpamixer
	ncmpcpp
	cmus
	mocp
	)

command=$(print -l $choices | fzf --prompt='tmux> ')

(( $#command == 0 )) && exit 0

tmux new-window $command
