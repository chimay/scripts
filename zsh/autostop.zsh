#! /usr/bin/env zsh

# vim: set filetype=sh :
# vim: set fdm=marker :

# Chemins d’accès {{{1

source ~/racine/config/cmdline/zsh/zprofile

# }}}1

# Variables {{{1

HOST=`hostname -s`

# }}}1

pkill xcape &

pkill -f wallpaper &

polybar-msg cmd quit &

pkill -10 sxhkd &

pkill -f mpv &

{
	pkill -f remind-server
	pkill -f remind
} &
