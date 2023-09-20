#!/usr/bin/env sh

# vim: set filetype=sh:

while true
do
	sortie=$(curl 'https://wttr.in/Louvain-la-Neuve?format=%C+%t+%H+%P+%w+%p+%m' 2>> ~/log/curl.err)

	if [ $? -eq 0 ]
	then
		echo $sortie
	else
		echo 'MET:INC'
	fi

	sleep 1800
done
