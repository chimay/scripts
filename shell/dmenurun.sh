#! /usr/bin/env sh

lignes=${1:-'30'}

exe=`dmenu_path | \
	dmenu -l $lignes \
	-b -i \
	-p "dmenu > " \
	-nb black -nf '#5b3c11' \
	-sb '#5b3c11' -sf black \
	-fn '-*-latin modern sansquotation-*-*-*-*-17-*-*-*-*-*-*-*' ${1+"$@"}` \
	&& exec $exe
