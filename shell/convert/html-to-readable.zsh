#!/usr/bin/env zsh

for page in "$@"
do
	short_page=${page%.html}-short.html
	[ -e $short_page ] && continue
	echo "readable $page >! $short_page"
	readable $page >! $short_page
done
