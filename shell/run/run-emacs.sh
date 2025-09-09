#! /usr/bin/env sh

xdotool search --name "emacs@$HOST" windowactivate && exit 0

initdir=~/racine/dotdir/emacs.d

echo Init directory :  $initdir
echo

exec emacs --init-directory $initdir "$@" >> ~/log/emacs.log 2>&1
