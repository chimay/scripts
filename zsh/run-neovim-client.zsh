#! /usr/bin/env zsh

xdotool search --class nvim-qt windowactivate && exit 0

# Choix de la version de nvim-qt {{{1

executable_qt=/usr/bin/nvim-qt

[ -e $executable_qt ] || executable_qt=/usr/local/bin/nvim-qt

if [ -e /usr/bin/nvim-qt -a -e /usr/local/bin/nvim-qt -a /usr/local/bin/nvim -nt /usr/bin/nvim  ]
then
	executable_qt=/usr/local/bin/nvim-qt
fi

echo Exécutable Qt : $executable_qt
echo

# }}}1

#SERVEUR=/tmp/neovim-serveur/0

SERVEUR=`echo /tmp/nvim*(/om[1])`/0

echo $SERVEUR
echo

exec $executable_qt \
	--geometry 1200x700
	--no-ext-tabline \
	--server $SERVEUR \
	-- \
	"$@"
