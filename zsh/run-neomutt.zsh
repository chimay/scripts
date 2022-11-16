#! /usr/bin/env zsh

temps=${1:-300}

alias psgrep='ps auxww | /bin/grep -v grep | /bin/grep --color=never'

pid=invalid

psgrep deliver-mail.sh || {

	echo "Launching deliver-mail.sh"
	echo

	deliver-mail.sh $temps &

	pid=$!
}

# echo "Synchronisation IMAP"
# mbsync -a

cd ~/racine/mail

neomutt "$@"

echo

[ $pid = invalid ] || {

	echo "Stopping deliver-mail.sh"
	echo

	kill -TERM $pid
}
