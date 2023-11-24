#!/usr/bin/env sh

notification=$1

message="$HOME/audio/bell/notification/mesange.ogg"

mpv-socket.bash add "$message" > ~/log/new-mail.log 2>&1
mpv-socket.bash volume 100 > ~/log/new-mail.log 2>&1

notify-send -a aerc 'New mail' "$notification"
