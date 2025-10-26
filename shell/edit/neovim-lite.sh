#!/usr/bin/env sh

rundir=$XDG_RUNTIME_DIR

if [ -d $rundir ]
then
	socket=$rundir/neovim-lite-socket
else
	socket=~/racine/run/socket/neovim-lite
fi

NVIM_APPNAME=neovim-lite nvim --listen $socket "$@"
