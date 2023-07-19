#! /usr/bin/env zsh

HOST=`hostname -s`

cd $HOME

RACINE=~/racine
CONFIG=$RACINE/config

[ -d .config ] || mkdir -p .config

linksfile=~/racine/self/links/racine-links.txt

while read line
do
	fields=(${(s/	/)line})
	link=$~fields[1]
	target=$~fields[2]
	link=${link//\$HOME/$HOME}
	target=${target//\$HOME/$HOME}
	target=${target//\$HOST/$HOST}
	echo $link '->' $target
done < $linksfile
