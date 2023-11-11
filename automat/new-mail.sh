#!/usr/bin/env sh

new=${1:-"unknown"}
unread=${2:-"unknown"}

message="$HOME/audio/bell/notification/mesange.ogg"

mpv-socket.bash add "$message" &>~/log/new-mail.log
mpv-socket.bash volume 100 &>~/log/new-mail.log

notify-send 'New mail' "$new new, $unread unread."
