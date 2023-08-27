#! /usr/bin/env sh

cd || exit 0

repo=${1:-$RESTIC_REPOSITORY}

[ $# -gt 0 ] && shift

restic \
	-r "$repo" \
	backup \
	--verbose=2 \
	--files-from ~/racine/list/backup/restic/include \
	--exclude-file ~/racine/list/backup/restic/exclude \
	"$@"
