#!/usr/bin/env zsh

for i in {0..255}; do
  printf '\e[38;5;%dm%3d \e[0m' "$i" "$i"
  (( (i + 1) % 16 == 0 )) && printf '\n'
done

echo

for i in {0..255}; do
  printf '\e[48;5;%dm %3d \e[0m' "$i" "$i"
  (( (i + 1) % 16 == 0 )) && printf '\n'
done
