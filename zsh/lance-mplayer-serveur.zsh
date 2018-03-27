#!/usr/bin/env /bin/zsh

# {{{ Options

emulate -R zsh

setopt local_options

setopt warn_create_global

#setopt extended_glob

#setopt null_glob

#zmodload zsh/regex

# }}}

local tube=~/racine/run/fifo/mplayer

[[ -p $tube ]] || {

	[[ -e $tube ]] && rm -f $tube

	mkfifo $tube
}

# -noconsolecontrols ?

mplayer -idle -slave -input file=$tube &>> ~/log/mplayer.log &!
