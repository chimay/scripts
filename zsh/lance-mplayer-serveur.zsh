#!/usr/bin/env /bin/zsh

# {{{ Options

emulate -R zsh

setopt local_options

setopt warn_create_global

#setopt extended_glob

#setopt null_glob

#zmodload zsh/regex

# }}}

# Déjà lancé ? {{{1

alias psgrep="ps auxww | grep -v grep | grep --color=never"

psgrep 'mplayer -idle -slave' &> /dev/null && {

	echo "Mplayer tourne déjà"
	echo

	exit 0
}

# }}}1

local tube=~/racine/run/fifo/mplayer

[[ -p $tube ]] || {

	[[ -e $tube ]] && rm -f $tube

	mkdir -p ~/racine/run/fifo

	mkfifo $tube
}

# -noconsolecontrols ?

mplayer \
	-idle \
	-slave \
	-input file=$tube \
	-softvol \
	-softvol-max 150 \
	&>>! ~/log/mplayer.log &!
