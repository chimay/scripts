#!/usr/bin/env sh

name=$1
shift
paths=$@

echo name : $name
echo paths : $paths
echo

tar -cvJf - $paths | age -p - > $name.tar.xz.age
