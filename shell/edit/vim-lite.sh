#!/usr/bin/env sh

exec vim \
	-u ~/racine/config/edit/vim-lite/vimrc \
	--cmd 'let &runtimepath = substitute(&runtimepath, $HOME."/\.vim", "$HOME/.vim-lite", "g")' \
	--cmd 'let &packpath = substitute(&packpath, $HOME."/\.vim", "$HOME/.vim-lite", "g")' \
	"$@"
