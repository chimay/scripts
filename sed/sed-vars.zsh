#! /usr/bin/env zsh

sed \
	-e 's+\$HOST+'$HOST'+g' \
	-e 's+\$HOME+'$HOME'+g' \
	-e 's+\$USER+'$USER'+g' \
	-e 's+\$PATH+'$PATH'+g' \
	$@
