#! /usr/bin/env sh

xdotool search --class nvim-qt windowactivate && exit 0

#UID=$(id -u)
#rundir=/run/user/$UID

rundir=$XDG_RUNTIME_DIR

if [ -d $rundir ]
then
	socket=$rundir/neovim-socket
else
	socket=~/racine/run/socket/neovim
fi

#	--no-ext-tabline \
#	--geometry 1200x700 \

# exec nvim-qt \
# 	--nofork \
# 	--server $socket \
# 	-- \
# 	"$@" >> ~/log/neovim-qt-client.log 2>&1

nvim-qt \
	--server $socket \
	-- \
	"$@" >> ~/log/neovim-qt-client.log 2>&1

which nvr || exit 0
sleep 1
nvr --remote-send '<cmd>call library#equal_windows()<cr>'
