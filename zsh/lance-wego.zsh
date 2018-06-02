#!/usr/bin/env /bin/zsh

[ $HOST = shari ] || exit 0

echo
echo "=================================="
echo " " $(date +"%H : %M %A %d %B %Y")
echo "=================================="
echo

~/racine/bin/go/bin/wego
