#!/usr/bin/env sh

# solution 1 : run nvim and nvim-qt at the same time {{{1

# ---- only works when no other nvim is running
# ---- how to tell nvim-qt to use another socket ?

# NVIM_APPNAME=neovim-lite nvim-qt \
# 	-- \
# 	"$@" >> ~/log/neovim-qt-lite.log 2>&1

# exit 0

# solution 2 : run nvim before nvim-qt {{{1

# ---- we need neovim-remote to add files on a running neovim
which nvr || {
	echo Please install neovim-remote with pip first
	exit 0
}

# ---- log and err files
logfile=~/log/neovim-qt-lite.log
errfile=~/log/neovim-qt-lite.err
# ---- save old channels
exec 3>&1
exec 4>&2
# ---- ensure log and err files exist
[ -e $logfile ] || touch $logfile
[ -e $errfile ] || touch $errfile
# ---- redirect to log and err files
exec 1>> $logfile
exec 2>> $errfile

rundir=$XDG_RUNTIME_DIR

if [ -d $rundir ]
then
	socket=$rundir/neovim-qt-lite-socket
else
	socket=~/racine/run/socket/neovim-qt-lite
fi

echo neovim lite socket : $socket
echo

if [ -S $socket -o -e $socket ]
then
	# ---- neovim server lite already runs,
	# ---- let's add args files to it
	nvr --servername $socket --remote-tab "$@"
else
	# ---- no nvim server lite, let's run it
	NVIM_APPNAME=neovim-lite nvim --listen $socket --headless "$@" &
fi

nvim-qt --server $socket

# ---- restore old channels
exec 1>&3
exec 2>&4
