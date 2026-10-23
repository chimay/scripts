#!/usr/bin/env sh

# exit 0 = can suspend, non-zero = stay awake

# ssh {{{1

pgrep -ax ssh && exit 1

# multimedia {{{1

pgrep -af vlc && exit 1
pgrep -af freetube && exit 1

mpc status | grep playing && exit 1

# exit {{{1

exit 0
