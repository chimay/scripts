#! /usr/bin/env sh

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

if [ -S $socket -o -e $socket ]
then
	echo 'neovim is already started'
	echo
	exit 0
fi

echo
echo "------------------------------------------------------------"
echo
date +" [=] %A %d %B %Y  (o) %H : %M : %S  | %:z | "
echo

# ---- restore old channels
exec 1>&3
exec 2>&4

exec nvim --listen $socket --headless >> $logfile 2>&1
