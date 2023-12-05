#!/usr/bin/env zsh

# vim: set filetype=sh:

for dir in *(/F)
do
	ls -i $dir/*(.) | sort -n
done | awk '{ print "  " NR "\t" $1 "\t" $2}'
