#! /usr/bin/env sh

xdotool search --class nvim-qt windowactivate && exit 0

# ---- we need neovim-remote to equalize windows
which nvr || {
	echo Please install neovim-remote with pip first
	exit 0
}

# ---- log and err files
logfile=~/log/neovim-server.log
errfile=~/log/neovim-server.err
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
	socket=$rundir/neovim-socket
else
	socket=~/racine/run/socket/neovim
fi

nvim-qt --server $socket -- "$@"

# ---- restore old channels
exec 1>&3
exec 2>&4

sleep 1
nvr --remote-expr 'library#equal_windows()'
