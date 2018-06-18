#! /usr/bin/env zsh

xdotool search --classname Navigator windowactivate && exit 0

exec firefox
