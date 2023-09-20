#!/bin/sh

pattern=$1
shift
awk '/^" ---- helpers/,/^" ---- [^h]/{print FILENAME, NR, $0}' "$@" | grep $pattern
