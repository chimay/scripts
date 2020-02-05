# vim: set filetype=zsh:

page=$(man -k . |
	dmenu -b -l 30 -p "Manuel : " -nb black -nf '#5b3c11' -sb '#5b3c11' -sf black $* |
	awk '{print $1}')

man -Tpdf $page | zathura -
