#!/usr/bin/env zsh

update-desktop-database ~/.local/share/applications

desktop_file=$(for f in /usr/share/applications/*.desktop \
	~/.local/share/applications/*.desktop
do
  [[ -f $f ]] && print -- $f
done | fzf)

echo $desktop_file
echo

echo -n "edit ? "
read answer

[ -z $answer ] && exit 0
[ $answer != y -a $answer != yes ] && exit 0

neovim-lite.sh $desktop_file
