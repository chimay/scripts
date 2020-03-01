#!/usr/bin/env /bin/zsh

# vim: set filetype=zsh:

echo Autowake : $(date +"%H:%M %A %d %B %Y")
echo

pkill -10 -f remind-server
