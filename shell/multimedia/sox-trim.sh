#! /usr/bin/env sh

infile=$1
outfile=$2
duration=$3

sox "$infile" "$outfile" trim 0 "$duration"
