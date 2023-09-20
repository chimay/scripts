#! /usr/bin/env sh

xdotool search --name "emacs@$HOST" windowactivate && exit 0

source ~/racine/config/shell/utils/profile

exec emacs "$@"
