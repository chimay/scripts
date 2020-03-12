#!/usr/bin/env /bin/zsh

# vim: set filetype=zsh:

bspc subscribe node_add | while read ligne
do
	bspc node -f $(echo $ligne | awk '{print $5}')
	bspc node -s biggest.local
done &
