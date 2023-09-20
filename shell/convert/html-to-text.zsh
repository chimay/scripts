#!/usr/bin/env zsh

for page in **/*.html
do
	text=${page%.html}.txt
	[ -e $text ] && continue
	echo "w3m -dump $page >! $text"
	w3m -dump $page >! $text
done
