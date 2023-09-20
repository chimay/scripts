#! /usr/bin/env zsh

temps=($1)
shift

echo Temps : $temps
echo

cat <<- FIN | at $temps 2> ~/log/at.err
	mpc play
FIN

echo

atq
