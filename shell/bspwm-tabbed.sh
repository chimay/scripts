#!/usr/bin/env /bin/sh

# vim: set filetype=sh:

# Credit:
# https://www.reddit.com/r/bspwm/comments/etfm3m/for_those_who_like_tabs/

tabbed=$(bspc query -N -n focused); \
child=$(tabbed-client.sh $tabbed list | head -n1); \
tabbed-client.sh $tabbed remove $child
