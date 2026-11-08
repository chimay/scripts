#!/usr/bin/env zsh

# init {{{1

packages=()

# terminal multiplexer {{{1

packages+=(
	herdr@latest
)

# edit {{{1

packages+=(
	neovim@nightly
)

# upgrade {{{1

mise upgrade

echo

# install {{{1

for pack in $=packages
do
	mise use $pack
done
