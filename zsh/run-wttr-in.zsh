#!/usr/bin/env zsh

lieu=${1:-Paris}

echo
echo "=================================="
echo " " $(date +"%H : %M %A %d %B %Y")
echo "=================================="
echo

curl wttr.in/$lieu 2>~/log/wttr-in.err.log
