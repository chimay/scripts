#!/usr/bin/env sh

pgrep -f freetube && {
	notify-send "freetube is running" "please stop it before suspending"
	exit 0
}

dms ipc call powermenu toggle
