#!/usr/bin/env zsh

for page in "$@"
do
	text=${page%.html}.txt
	[ -e $text ] && continue
	echo "readable $page | w3m -T text/html -dump >! $text"
	readable $page | w3m -T text/html -dump >! $text
done
