#! /usr/bin/env sh

if [ $1 = -n ]
then
	shift
	network=1
fi

if [ $# -eq 0 ]
then
	echo 'Usage : goto-or-run.sh [-n] application'
fi

application=$1
shift

xdotool search --class $application windowactivate && exit 0

if [ $network -eq 1 ]
then
	teste-connexion.zsh
fi

exec $application "$@"
