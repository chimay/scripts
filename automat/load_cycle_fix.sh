#! /usr/bin/env sh

# TEMPDIR=$(mktemp -d -t temp.XXXXXX)

TEMPDIR=~/tmp

[ -d $TEMPDIR ] || mkdir $TEMPDIR

while true
do
	sleep 3
	echo " " > $TEMPDIR/load_cycle_fix
done
