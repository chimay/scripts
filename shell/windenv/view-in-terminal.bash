#!/usr/bin/env bash

credit: https://www.youtube.com/watch?v=oFCrwS01mDs

command="$@"

alacritty -e bash -c "$command ; tput setaf 1 ; read -p 'Press any key to continue.' -s -n 1"
