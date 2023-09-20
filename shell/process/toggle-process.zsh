#!/usr/bin/env zsh
# vim: set filetype=zsh:

[ $# -eq 0 ] && {
	echo Usage : ${0##*/} process-name
	exit 0
}

process=$1

nominees=("${(f)$(ps -A -o pid,state,args | grep $process | grep -v grep | grep -v $0)}")

# print -l $nominees
# echo $#nominees

[ $#nominees -gt 1 ] && {
	echo There is more than one match, you have to be more specific.
	exit 0
}

procinfo=$nominees[1]

espaces=${procinfo%%[^[:blank:]]*}
procinfo=${procinfo#${espaces}}

# echo Process info
# print -l $procinfo

pid=$(cut -d ' ' -f 1 <<< $procinfo)
state=$(cut -d ' ' -f 2 <<< $procinfo)

echo pid : $pid
echo state : $state

if [ $state = T ]
then
	echo "kill -CONT $pid"
	echo
	kill -CONT $pid
elif [ $state = R -o $state = S ]
then
	echo "kill -STOP $pid"
	echo
	kill -STOP $pid
else
	echo Your process is in a ambiguous state.
fi

exit 0
