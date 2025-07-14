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

exec emacs --daemon >> ~/log/emacs-server.log 2>&1
