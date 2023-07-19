#! /usr/bin/env zsh

cd ~/racine/self/chezmoi/source

for file in **/symlink_*
do
	link=\$HOME/$file
	link=${link//symlink_/}
	link=${link//dot_/.}
	target=$(<$file)
	target=${target//{{ .chezmoi.homeDir }}/\$HOME}
	target=${target//{{ .chezmoi.hostname }}/\$HOST}
	printf '%s\t%s\n' $link $target
done
