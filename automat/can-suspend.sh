#!/usr/bin/env sh

# exit 0 = can suspend, non-zero = stay awake

# exact {{{1

pgrep -ax ssh && exit 1

# part {{{1

pgrep -af vlc && exit 1
pgrep -af freetube && exit 1

# exit {{{1

exit 0
