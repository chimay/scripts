#! /usr/bin/env zsh

local file=$1
local suffix next

[[ -e $file ]] || {
	echo file $file does not exist
	echo
	return 1
}

[[ -e $file.7 ]] && {
	echo trash-put $file.7
	echo
	trash-put $file.7
}

for suffix in {6..1}
do
	(( next = suffix + 1 ))
	[[ -e $file.$suffix ]] && {
		echo mv $file.$suffix $file.$next
		echo
		mv $file.$suffix $file.$next
	}
done

echo command cp $file $file.1
echo
command cp $file $file.1

exit 0
