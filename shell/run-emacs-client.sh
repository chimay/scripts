#! /usr/bin/env sh

xdotool search --name "emacs@$HOST" windowactivate && exit 0

exec emacsclient -c -n "$@"
