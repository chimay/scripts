# vim: set filetype=sh:

dmenu_path | \
	dmenu -p 'Application : ' -b -l 35 -fn "DejaVu Sans Mono 12" -nb black -nf '#5b3c11' -sb '#5b3c11' -sf black "$@" | \
	${SHELL:-"/bin/sh"} &
