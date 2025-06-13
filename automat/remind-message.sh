#! /usr/bin/env sh

#bell.zsh ~/audio/bell/ding/yinyang.ogg
notify-send Reminder "$@"

logfile=~/log/remind-msg.log

{
	date +"[=] %A %d %B %Y  (o) %H : %M : %S  | %:z | "
	echo
	echo $@
	echo
} >> $logfile
