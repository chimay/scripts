#!/usr/bin/env sh
# AUTHOR: gotbletu (@gmail|twitter|youtube|github|lbry)
#         https://www.youtube.com/user/gotbletu
# DESC:   set dragon drag and drop program to be always on top
# DEMO:   https://youtu.be/ukIG_OVXa3Q
# DEPEND: wmctrl sed gawk dragon (https://github.com/mwh/dragon)
# REFF:

dragon='dragon-drag-and-drop --on-top'

if [ "$1" = -h ] || [ "$1" = --help ]; then
  $dragon --help | sed "s/dragon/${0##*/}/g"
  exit 0
else
  $dragon "$@"
fi
