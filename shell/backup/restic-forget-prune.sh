#! /usr/bin/env sh

cd || exit 0

repo=${1:-$RESTIC_REPOSITORY}

[ $# -gt 0 ] && shift

echo
echo restic forget
echo

restic \
	-r "$repo" \
	forget \
	--keep-daily 7 \
	--keep-weekly 4 \
	--keep-monthly 12 \
	--keep-yearly 7 \
	--prune \
	"$@"

echo
echo restic check
echo

restic -r "$repo" check

echo
echo
echo restic snapshots
echo

restic -r "$repo" snapshots -c
