#! /usr/bin/env zsh

cd ~/racine/self/chezmoi/source

for file in **/symlink_*
do
	link=\$HOME/$file
	link=${link//.tmpl/}
	link=${link//symlink_/}
	link=${link//private_/}
	link=${link//dot_/.}
	target=$(<$file)
	target=${target//{{ .chezmoi.homeDir }}/\$HOME}
	target=${target//{{ .chezmoi.hostname }}/\$HOST}
	target=${target//{{ .chezmoi.sourceDir }}/\$HOME/racine/self/chezmoi/source}
	printf '%s\t%s\n' $link $target
done
