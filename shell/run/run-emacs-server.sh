#! /usr/bin/env sh

{
	echo
	echo "------------------------------------------------------------"
	echo
	date +" [=] %A %d %B %Y  (o) %H : %M : %S  | %:z | "
	echo
} >> ~/log/emacs-server.log 2>&1

pgrep 'emacs.*daemon' > ~/log/psgrep.log 2>&1 && {
	echo 'emacs is already running'
	echo
	exit 0
} >> ~/log/emacs-server.log 2>&1

initdir=~/racine/dotdir/emacs.d

echo Init directory :  $initdir
echo

exec emacs --init-directory $initdir --daemon >> ~/log/emacs-server.log 2>&1
