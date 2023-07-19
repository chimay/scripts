#! /usr/bin/env zsh

#HOST=`hostname -s`

#cd $HOME

[ -d .config ] || mkdir -p .config

linksfile=${1:-~/racine/self/links/racine-links.txt}

while read line
do
	fields=(${(s/	/)line})
	link=$~fields[1]
	target=$~fields[2]
	link=${link//\$HOME/$HOME}
	target=${target//\$HOME/$HOME}
	target=${target//\$HOST/$HOST}
	#echo $link '->' $target
	[ -L $link ] && {
		#echo link $link already exists
		continue
	}
	[ -e $link ] && {
		echo $link already exists
		continue
	}
	echo "ln -sf $target $link"
	ln -sf $target $link
done < $linksfile
