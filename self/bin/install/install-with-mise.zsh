#!/usr/bin/env zsh

# init {{{1

packages=()

# terminal multiplexer {{{1

packages+=(
	aqua:Gaurav-Gosain/tuios@latest
	herdr@latest
	#workmux@latest
)

# edit {{{1

packages+=(
	neovim@nightly
)

# file managers {{{1

packages+=(
	superfile@latest
)

# upgrade {{{1

echo "mise upgrade"
echo

mise upgrade

echo

# install {{{1

for pack in $=packages
do
	echo "mise use --global $pack"
	echo
	mise use --global $pack
	echo
done
