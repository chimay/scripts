#! /usr/bin/env sh

folder=$1
shift

args="$@"

echo "sxiv -to $args | xargs -I{} mv {} $folder"
echo

sxiv -to $args | xargs -I{} mv {} $folder
