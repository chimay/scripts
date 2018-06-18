#! /usr/bin/env zsh

xdotool search --name emacs@$HOST windowactivate && exit 0

# Choix de la version d’emacs {{{1

if [[ /usr/bin/emacs -nt /usr/local/bin/emacs  ]]
then
	executable=/usr/bin/emacs
else
	executable=/usr/local/bin/emacs
fi

echo Exécutable : $executable
echo

# }}}1

source ~/racine/config/cmdline/shell/profile

exec $executable "$@"
