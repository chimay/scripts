#! /usr/bin/env sh

xdotool search --class nvim-qt windowactivate && exit 0

rundir=$XDG_RUNTIME_DIR

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

if [ ! -z $rundir -a -d $rundir ]
then
	socket=$rundir/neovim-socket
else
	socket=~/run/socket/neovim
fi

echo neovim qt client socket : $socket
echo

if [ -S $socket ]
then
	nvim-qt --server $socket -- "$@"
else
	nvim-qt -- "$@"
fi

# ---- restore old channels
exec 1>&3
exec 2>&4

sleep 1

if [ -S $socket ]
then
	nvim --server $socket --remote-expr 'library#equal_windows()'
else
	nvim --remote-expr 'library#equal_windows()'
fi
