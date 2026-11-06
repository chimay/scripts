#!/usr/bin/env sh

if which systemctl 2> /dev/null
then
	powerctl=systemctl
else
	powerctl=loginctl
fi

sync

$powerctl suspend

autowake.zsh &>> ~/log/autowake.log
