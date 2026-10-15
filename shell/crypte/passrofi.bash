#!/usr/bin/env bash

shopt -s nullglob

prefix="${PASSWORD_STORE_DIR:-$HOME/.password-store}"
entries=()

while IFS= read -r -d '' file
do
    entries+=("${file#"$prefix"/}")
done < <(find "$prefix" -type f -name '*.gpg' -print0)

((${#entries[@]})) || exit 0

selected=$(printf '%s\n' "${entries[@]%.gpg}" |
    sort |
    rofi -dmenu -i -p 'Password')

[[ -n $selected ]] || exit 0

pass -c "$selected"
