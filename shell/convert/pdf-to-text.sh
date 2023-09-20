#!/usr/bin/env sh

for page in "$@"
do
	text=${page%.pdf}.txt
	echo "pdftotext $page > $text"
	pdftotext $page >! $text
done

