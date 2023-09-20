#!/bin/sh

# vim: set filetype=sh:

temps=${1:-300}

while true
do
	getmail >> ~/log/getmail.log 2>> ~/log/getmail.err
	sleep $temps
done
