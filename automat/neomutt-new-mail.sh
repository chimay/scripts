#!/usr/bin/env sh

new=${1:-"unknown"}
unread=${2:-"unknown"}

message="$HOME/audio/bell/notification/mesange.ogg"

mpv-socket.bash add "$message" > ~/log/new-mail.log 2>&1
mpv-socket.bash volume 100 > ~/log/new-mail.log 2>&1

notify-send -a neomutt 'New mail' "$new new, $unread unread."
