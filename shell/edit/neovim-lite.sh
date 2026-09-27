#!/usr/bin/env sh

export PATH=~/.local/share/mise/installs/neovim/nightly/bin:$PATH

rundir=$XDG_RUNTIME_DIR

# ( cat /dev/urandom | base64 | tr -dc '0-9a-zA-Z' | head -c 100 ) 2> /dev/null

suffix=$(cat /dev/urandom | base64 | tr -dc '0-9a-zA-Z' | head -c 10)

if [ ! -z $rundir -a -d $rundir ]
then
	socket=$rundir/neovim-lite-socket.$suffix
else
	socket=~/run/socket/neovim-lite.$suffix
fi

NVIM_APPNAME=neovim-lite nvim --listen $socket "$@"
