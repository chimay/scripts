#! /usr/bin/env sh

repo=${1:-$RESTIC_REPOSITORY}

[ $# -gt 0 ] && shift

echo
echo restic forget
echo

restic \
	-r "$repo" \
	forget \
	--keep-last 12 \
	--keep-daily 7 \
	--keep-weekly 4 \
	--keep-monthly 12 \
	--keep-yearly 7 \
	--prune \
	"$@"
