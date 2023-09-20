#! /usr/bin/env zsh

cd ~/audio

exec vlc --extraintf rc --rc-host 127.0.0.1:8080 "$@"
