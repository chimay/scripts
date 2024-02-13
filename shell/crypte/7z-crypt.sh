#!/usr/bin/env sh

name=$1
shift
paths=$@

echo name : $name
echo paths : $paths
echo

7z a -mhe=on -p $name.7z $paths
