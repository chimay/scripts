#!/usr/bin/env sh

# exit 0 = can suspend, non-zero = stay awake

# ssh {{{1

pgrep -x ssh && exit 1

# backup {{{1

pgrep -x borg && exit 1
pgrep -x restic && exit 1

# multimedia {{{1

pgrep -x vlc && exit 1
pgrep -x freetube && exit 1

mpc status | grep playing && exit 1

# exit {{{1

exit 0
