#! /usr/bin/env sh

# necessary because ~/racine/index/backup/restic/include
# contains paths relative to home directory
cd || exit 0

# see also <url:~/racine/config/shell/zsh/zshenv#tn=RESTIC_PASSWORD_COMMAND>

repo=${1:-$RESTIC_REPOSITORY}

[ $# -gt 0 ] && shift

echo
echo restic backup
echo

restic \
	-r "$repo" \
	backup \
	--verbose=1 \
	--files-from ~/racine/index/backup/restic/include \
	--exclude-file ~/racine/index/backup/restic/exclude \
	"$@" | tee -a ~/log/restic.log

restic-forget-prune.sh "$repo"
restic-check.sh "$repo"
