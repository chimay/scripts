#!/usr/bin/env sh

exec vim -f \
	-u ~/racine/config/edit/vim-mail/vimrc \
	--cmd 'let &runtimepath = substitute(&runtimepath, $HOME."/\.config/vim", "$HOME/.config/vim-mail", "g")' \
	--cmd 'let &packpath = substitute(&packpath, $HOME."/\.config/vim", "$HOME/.config/vim-mail", "g")' \
	"$@"
