#! /usr/bin/env zsh

xdotool search --name emacs@$HOST windowactivate && exit 0

# Choix de la version d’emacs {{{1

alias psgrep='ps auxww | /bin/grep -v grep | /bin/grep --color=auto'

processus=$(psgrep emacs)

if [[ $processus = */usr/bin/emacs*  ]]
then
	emacsclient=/usr/bin/emacsclient
else
	emacsclient=/usr/local/bin/emacsclient
fi

# if [[ /usr/bin/emacs -nt /usr/local/bin/emacs  ]]
# then
# 	emacsclient=/usr/bin/emacsclient
# else
# 	emacsclient=/usr/local/bin/emacsclient
# fi

echo Emacsclient : $emacsclient
echo

# }}}1

exec $emacsclient -c -n "$@"
