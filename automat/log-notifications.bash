#!/bin/bash

# credit : https://askubuntu.com/questions/770218/how-can-i-log-all-notify-send-actions

file=$1

dbus-monitor "interface='org.freedesktop.Notifications'" |\
 grep --line-buffered "string" |\
 grep --line-buffered -e method -e ":" -e '""' -e urgency -e notify -v |\
 grep --line-buffered '.*(?=string)|(?<=string).*' -oPi |\
 grep --line-buffered -v '^\s*$' |\
 grep --line-buffered -v 'sender-pid' |\
 xargs -I '{}' printf "$(date)\n{}\n" >> $file
