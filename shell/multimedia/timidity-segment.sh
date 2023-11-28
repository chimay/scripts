#!/usr/bin/env sh

begin=$1
end=$2
shift ; shift
arguments="$*"

echo timidity -G"$begin"-"$end"m "$arguments"
timidity -G"$begin"-"$end"m "$arguments"
