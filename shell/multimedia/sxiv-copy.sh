#! /usr/bin/env sh

echo -n "Destination folder ? "
read folder

echo "sxiv -to $@ | xargs -I{} cp {} $folder"

sxiv -to "$@" | xargs -I{} cp {} $folder
