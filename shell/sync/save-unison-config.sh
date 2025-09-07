#!/usr/bin/env sh

args="$@"

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

echo "syncron $args ~/racine/config/sync/unison/ ~/racine/syncron/unison/$HOST"
echo
syncron $args ~/racine/config/sync/unison/ ~/racine/syncron/unison/$HOST
