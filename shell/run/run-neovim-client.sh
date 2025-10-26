#! /usr/bin/env sh

rundir=$XDG_RUNTIME_DIR

if [ -d $rundir ]
then
	socket=$rundir/neovim-socket
else
	socket=~/racine/run/socket/neovim
fi

exec nvim --server $socket --remote-ui "$@"
