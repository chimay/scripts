#!/usr/bin/env zsh

if [ $# -gt 0 ]
then
	arg=($@)
else
	arg=(**/*(.))
fi

wc -l $=arg | awk '{print $1}' | { tr '\n' '+' ; echo 0 } | bc
