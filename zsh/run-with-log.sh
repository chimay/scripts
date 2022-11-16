#!/usr/bin/env sh

if [ $1 = -t ]
then
	shift
	teste-connexion.zsh
fi

application=$1

$application &> ~/log/$application.log &
