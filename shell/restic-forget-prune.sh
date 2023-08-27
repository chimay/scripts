#! /usr/bin/env sh

cd || exit 0

repo=${1:-$RESTIC_REPOSITORY}

[ $# -gt 0 ] && shift

restic \
	-r "$repo" \
	forget \
	--keep-daily 7 \
	--keep-weekly 4 \
	--keep-monthly 12 \
	--keep-yearly 7 \
	--prune \
	"$@"

restic -r "$repo" check
