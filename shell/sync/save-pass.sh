#!/usr/bin/env sh

# functions {{{1

syncron () {
	rsync \
		--verbose \
		--progress \
		--stats \
		--human-readable \
		--itemize-changes \
		--log-file="$HOME/log/rsync.log" \
		--rsh=ssh \
		--recursive \
		--modify-window=1 \
		--owner \
		--group \
		--times \
		--perms \
		--links \
		--update \
		"$@"
}

copyforce () {
	rsync \
		--verbose \
		--progress \
		--stats \
		--human-readable \
		--itemize-changes \
		--log-file="$HOME/log/rsync.log" \
		--rsh=ssh \
		--recursive \
		--modify-window=1 \
		--owner \
		--group \
		--times \
		--perms \
		--links \
		--ignore-times \
		"$@"
}

# open pass {{{1

pass_was_open=1

tomb list || {
	pass_was_open=0
	pass open -vf || exit 1
}

# backup password-store {{{1

syncron ~/.password-store/ password-store-tomb

# close pass {{{1

pass close -v || exit 1

# backup tomb and key {{{1

cd ~/racine/config/crypte

copyforce password.tomb password.tomb.bak
copyforce password.tomb.key password.tomb.key.bak

# reopen pass {{{1

[ $pass_was_open -eq 1 ] && pass open -vf
