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

# ---- builtin in neovim now
# neovim-remote
# ---- miscellaneous
# py3exiv2

packages=(
	edir          # vidir improved
	vimiv         # vim-like image viewer
	trafilatura   # cli tool for readable
	tldextract    # for qute-pass
	getmail
	dbus-python
	pyright       # python syntax in neovim
	debugpy       # python debug in neovim
	eg
	pikaur
	'aria2p[tui]'
	wptranslate
	zxcvbn pyaml
	mausoleum
	piexif
	yt-dlp
)

echo "pip install --upgrade $=packages"
echo
pip install --upgrade $=packages
