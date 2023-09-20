#!/usr/bin/env bash

# Credit :
# https://gist.github.com/dwgill/a66769e0edef69c04d3b

# Currently, I’ve :
#   - added the volume subcommand
#   - modified the socket var

# This script requires:
# - that the directory $socket exist
# - that the program socat be installed
# - that you start mpv with the unix socket feature pointing at that directory
#   I recommend an alias in your .bashrc or equivalent file:
#       alias mpv="mpv --input-unix-socket=your-socket-file"

# You can start an mpv server in the autostart script of your
# X environment with a line like this :
#
# mpv --idle --input-ipc-server=$HOME/racine/run/socket/mpv &> ~/log/mpv-socket.log &

socket="$HOME/racine/run/socket/mpv"

mpv-msg() {
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
