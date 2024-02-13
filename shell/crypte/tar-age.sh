#!/usr/bin/env sh

folder=${1:-$(pwd)}
name=${folder##*/}

echo folder : $folder
echo name : $name
echo

tar -cvJf - $folder | age -p - > $name.tar.xz.age
