#!/usr/bin/env zsh

# vim: set filetype=zsh :

# Options {{{1

emulate -R zsh

setopt local_options

setopt warn_create_global

setopt extended_glob

# }}}1

# Fonctions {{{1

mpv-msg() {
    local tosend=''
	local arg
    for arg in "$@"; do
        tosend="$tosend \"$arg\" "
    done
	echo $tosend
	echo $tosend > ~/racine/run/pipe/mpv
}

# }}}1

# exit mpv
[ "$1" = "quit" ] && mpv-msg 'quit'
# adjust volume
[ "$1" = "volume" ] && mpv-msg 'set' 'volume' $2
# toggle play-pause
[ "$1" = "play-pause" ] && mpv-msg 'cycle' 'pause'
# start playing
[ "$1" = "pause" ] && mpv-msg 'set' 'pause' 'yes'
# stop playing
[ "$1" = "play" ] && mpv-msg 'set' 'pause' 'no'
# play next item in playlist
[ "$1" = "next" ] && mpv-msg 'playlist_next'
# play previous item in playlist
[ "$1" = "previous" ] && mpv-msg 'playlist_prev'
# add item(s) to playlist
[ "$1" = "add" ] && shift &&
    for video in "$@"; do
        mpv-msg 'loadfile' "$video" 'append-play';
    done;
# replace
[ "$1" = "replace" ] && mpv-msg 'loadfile' "$2" 'replace';
