#!/usr/bin/env bash

# Credit :
# https://gist.github.com/dwgill/a66769e0edef69c04d3b

# Currently, I’ve just added the volume subcommand

# This script requires:
# - that the directory $HOME/.mpv exist
# - that the program socat be installed
# - that you start mpv with the unix socket feature pointing at that directory
#   I recommend an alias in your .bashrc or equivalent file:
#       alias mpv="mpv --input-unix-socket=$HOME/.mpv/socket"

socket="$HOME/racine/run/socket/mpv"

command() {
    # JSON preamble.
    local tosend='{ "command": ['
    # adding in the parameters.
    for arg in "$@"; do
        tosend="$tosend \"$arg\","
    done
    # closing it up.
    tosend=${tosend%?}' ] }'
	echo $tosend
    # send it along and ignore output.
    # to print output just remove the redirection to /dev/null
    echo $tosend | socat - $socket &> /dev/null
}

# exit mpv
[ "$1" = "quit" ] && command 'quit'
# adjust volume
[ "$1" = "volume" ] && command 'set' 'volume' $2
# toggle play-pause
[ "$1" = "play-pause" ] && command 'cycle' 'pause'
# start playing
[ "$1" = "pause" ] && command 'set' 'pause' 'yes'
# stop playing
[ "$1" = "play" ] && command 'set' 'pause' 'no'
# play next item in playlist
[ "$1" = "next" ] && command 'playlist_next'
# play previous item in playlist
[ "$1" = "previous" ] && command 'playlist_prev'
# add item(s) to playlist
[ "$1" = "add" ] && shift &&
    for video in "$@"; do
        command 'loadfile' "$video" 'append-play';
    done;
