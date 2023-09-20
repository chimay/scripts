#! /usr/bin/env sh

cd || exit 0

repo=${1:-$RESTIC_REPOSITORY}

[ $# -gt 0 ] && shift

echo
echo restic backup
echo

restic \
	-r "$repo" \
	backup \
	--verbose=2 \
	--files-from ~/racine/index/backup/restic/include \
	--exclude-file ~/racine/index/backup/restic/exclude \
	"$@" | tee -a ~/log/restic.log

restic-forget-prune.sh "$repo"
