#!/usr/bin/env zsh

# {{{ Options

emulate -R zsh

setopt local_options

setopt warn_create_global

# }}}

# Déjà lancé ? {{{1

alias psgrep="ps auxww | grep -v grep | grep --color=never"

psgrep 'mpv --idle --input-file' &> /dev/null && {

	echo "mpv tourne déjà"
	echo

	exit 0
}

# }}}1

local tube=~/racine/run/pipe/mpv

[[ -p $tube ]] || {

	[[ -e $tube ]] && rm -f $tube

	mkdir -p ~/racine/run/pipe

	mkfifo $tube
}

mpv --idle --input-file=$tube &>>! ~/log/mpv.log &!
