#!/usr/bin/env bash

# credit: https://www.youtube.com/watch?v=oFCrwS01mDs

[ $# -eq 0 ] && {
	echo "Usage : $0 command"
	exit 0
}

command="$@"

alacritty -e bash -c "$command ; tput setaf 1 ; read -p 'Press any key to continue.' -s -n 1"
