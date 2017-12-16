#! /usr/bin/env zsh

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

exec $executable "$@"
