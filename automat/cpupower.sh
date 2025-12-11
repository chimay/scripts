#!/usr/bin/env sh

governor=$1

which cpupower >& /dev/null || {
	notify-send "Please install cpupower to use cpupower.sh"
	exit 1
}

sudo cpupower frequency-set -g $governor

message=$(cpupower frequency-info | grep 'The governor')

notify-send "$message"
