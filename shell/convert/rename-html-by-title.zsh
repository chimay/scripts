#!/usr/bin/env zsh

# Rename html file by title

html-title () {
	file=$1
	title=$(\
		grep -oP '<title>\K.+?</title>' $file | \
		sed 's#</title>##' | \
		sed 's/&#[^;]\+;//g' | \
		sed 's/ \+/_/g' | \
		sed 's/_{2,}/_/g' | \
		sed 's/[^a-zA-Z0-9_-]//g' \
	)
	echo $title
}

for file in "$@"
do
	title=$(html-title $file)
	mv -v $file $title.html
done
