#!/usr/bin/env sh

name=$1
shift
paths=$@

echo name : $name
echo paths : $paths
echo

tar -cvJf - $paths | gpg --symmetric > $name.tar.xz.gpg
