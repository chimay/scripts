#!/usr/bin/env zsh

# vim: set filetype=zsh:

for folder in *(/FOn)
do
	echo "touch $folder/*"
	touch $folder/*
	echo "sleep 1"
	sleep 1
done
