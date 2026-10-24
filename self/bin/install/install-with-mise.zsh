#!/usr/bin/env zsh

packages=()

packages+=(
	herdr@latest
	neovim@nightly
)


mise upgrade

echo

for pack in $=packages
do
	mise install $pack
done
