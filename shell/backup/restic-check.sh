#! /usr/bin/env sh

repo=${1:-$RESTIC_REPOSITORY}

echo
echo restic check
echo

restic -r "$repo" check

echo
echo restic snapshots
echo

restic -r "$repo" snapshots -c
