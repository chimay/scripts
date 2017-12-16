#! /usr/bin/env zsh

# Choix de la version d’emacs {{{1

if [[ /usr/bin/emacs -nt /usr/local/bin/emacs  ]]
then
	emacsclient=/usr/bin/emacsclient
else
	emacsclient=/usr/local/bin/emacsclient
fi

echo Emacsclient : $emacsclient
echo

# }}}1

exec $emacsclient -c -n "$@"
