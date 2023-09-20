#!/bin/zsh

filelist=(${*:-**/*.html})

for file in $=filelist
do
	sed -n '/^\s*#content { max-width:/p' $file
	sed -i '/^\s*#content { max-width:/d' $file
done
