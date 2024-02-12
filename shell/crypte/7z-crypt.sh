#!/usr/bin/env sh

name=$1
shift
paths=$@

#folder=${1:-$(pwd)}
#name=${folder##*/}

echo folder : $folder
echo name : $name
echo

7z a -mhe=on -p $name.7z $paths
