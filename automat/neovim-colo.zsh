#! /usr/bin/env zsh

time=${1:-1800}

cd ~/racine/plugin/manager/neovimpack/packager/opt/vim-colorschemes/colors

schemelist=$(print -l *.vim | shuf)

for scheme in $=schemelist
do
	colo=${scheme%.vim}
	echo nvr --remote-send ":colo $colo<cr>"
	nvr --remote-send ":colo $colo<cr>"
	sleep $time
done
