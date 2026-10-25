#!/usr/bin/env zsh

icon=$(for f in /usr/share/icons/**/*.(svg|png|xpm|webp)
do
  [[ -f $f ]] && print -- $f
done | fzf)

echo $icon
echo
