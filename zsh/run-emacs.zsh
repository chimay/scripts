#! /usr/bin/env zsh

xdotool search --name emacs@$HOST windowactivate && exit 0

#xdotool windowactivate $(xdotool search --class Emacs | tail -n 1) && exit 0

# Choix de la version de emacs {{{1

executable=/usr/bin/emacs

if [ -e /usr/local/bin/emacs -a /usr/local/bin/nvim -nt /usr/bin/nvim  ]
then
	executable=/usr/local/bin/emacs
fi

echo Exécutable : $executable
echo

# }}}1

source ~/racine/config/cmdline/shell/profile

exec $executable "$@"
