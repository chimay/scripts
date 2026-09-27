#!/usr/bin/env sh

export PATH=~/.local/share/mise/installs/neovim/nightly/bin:$PATH

rundir=$XDG_RUNTIME_DIR

suffix=$(cat /dev/urandom | base64 | tr -dc '0-9a-zA-Z' | head -c 10)

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

if [ ! -z $rundir -a -d $rundir ]
then
	socket=$rundir/neovim-qt-lite-socket
	#socket=$rundir/neovim-qt-lite-socket.$suffix
else
	socket=~/run/socket/neovim-qt-lite
	#socket=~/run/socket/neovim-qt-lite.$suffix
fi

echo neovim qt lite socket : $socket
echo

if [ -S $socket -o -e $socket ]
then
	# ---- neovim server lite already runs,
	# ---- let's add args files to it
	echo "nvim --server $socket --remote-tab "$@""
	echo
	nvim --server $socket --remote-tab "$@"
else
	# ---- no nvim server lite, let's run it
	#NVIM_APPNAME=neovim-lite nvim --listen $socket --headless "$@" &
	echo "NVIM_APPNAME=neovim-lite nvim --listen $socket --headless &"
	echo
	NVIM_APPNAME=neovim-lite nvim --listen $socket --headless &
fi

nvim-qt --server $socket -- "$@"

# ---- restore old channels
exec 1>&3
exec 2>&4
