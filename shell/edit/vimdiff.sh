#!/usr/bin/env sh

basis=$1
shift
argumen="$@"

for file in $argumen
do
	[ $file = $basis ] && continue
	echo "vimdiff $basis $file"
	# :cq in vim sends non zero error code
	# and breaks the loop
	vimdiff $basis $file || break
done
