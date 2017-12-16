#! /usr/bin/env zsh

# Choix de la version de nvim {{{1

if [[ /usr/bin/nvim -nt /usr/local/bin/nvim  ]]
then
	executable=/usr/bin/nvim
else
	executable=/usr/local/bin/nvim
fi

echo Exécutable : $executable
echo

# }}}1

exec /usr/local/bin/nvim-qt \
	--nvim $executable \
	--geometry 1200x700 \
	-- \
	-u ~/racine/config/edit/neovim/init.vim \
	-c "cd ~/racine/plain" \
	"$@"

#exec pynvim -f Monospace 11
