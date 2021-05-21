#!/usr/bin/env zsh

for file in "$@"
do
	jq 'del(.assocs, .xassocs, .viewers)' $file | sponge $file
done
