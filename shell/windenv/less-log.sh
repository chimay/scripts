#!/usr/bin/env sh

# vim: set filetype=sh:

urxvtc -name journal -e less -f -r +G $@
