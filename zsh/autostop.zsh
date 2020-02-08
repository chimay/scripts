#! /usr/bin/env zsh

# vim: set filetype=sh :
# vim: set fdm=marker :

# Chemins d’accès {{{1

source ~/racine/config/cmdline/zsh/zprofile

# }}}1

# Variables {{{1

HOST=`hostname -s`

# }}}1

kill -15 $(ps --no-headers -eo '%p %a' | grep -v grep | grep fond-ecran.zsh | awk '{ print $1 }')

polybar-msg cmd quit &

killall -10 sxhkd &
