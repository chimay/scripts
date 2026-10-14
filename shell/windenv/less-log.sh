#!/usr/bin/env sh

# vim: set filetype=sh:

#urxvtc -name journal -title journal -e less -f -r +G $@

kitty --single-instance --title journal less -f -r +G $@
