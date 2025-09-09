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

packages=(
	tldextract    # for qute-pass
	getmail
	edir
	neovim-remote
	vimiv
	'aria2p[tui]'
	readability
	wptranslate
	eg
)

echo "pip install --upgrade $=packages"
echo
pip install --upgrade $=packages
