#!/usr/bin/env zsh

pipdir=${1:-~/.pip}

if [ -e $pipdir ]
then
	echo $pipdir already exists
	echo
else
	echo "python -m venv $pipdir"
	echo
	python -m venv $pipdir
fi

echo "pip install --upgrade pip"
echo
pip install --upgrade pip


# packages {{{1

packages=()

# libraries {{{1

packages+=(
	tldextract    # for qute-pass
)

# package managers {{{1

packages+=(
	pikaur
)

# interpreters {{{1

packages+=(
	ipython
)

# multiplexers {{{1

packages+=(
	cmux
)

# network {{{1

packages+=(
	'aria2p[tui]'
)

# edit {{{1

packages+=(
	pyright       # python syntax in neovim
	debugpy       # python debug in neovim
)

# utils {{{1

packages+=(
	edir          # vidir improved
	trafilatura   # cli tool for readable
	wptranslate
)

# image {{{1

packages+=(
	vimiv         # vim-like image viewer
	piexif
	pywal
)

# mail {{{1

packages+=(
	getmail
)

# social {{{1

packages+=(
	toot-tooi
)

# documentation {{{1

packages+=(
	eg
)

# misc {{{1

packages+=(
	dbus-python
	zxcvbn
	pyaml
	mausoleum
	yt-dlp
)

echo "pip install --upgrade $=packages"
echo
pip install --upgrade $=packages
