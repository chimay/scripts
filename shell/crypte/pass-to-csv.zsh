#!/usr/bin/env zsh

[ $# -gt 0 ] && {
	[ $1 = -h -o $1 = --help ] && {
		echo "Generate a csv file from pass (www.passwordstore.org) database."
		echo "This csv file can be imported in keepassxc."
		echo
		echo "Usage: $(basename $0) password-store-directory csv-file"
		echo
		exit 0
	}
}

store=${1:-~/.password-store}

output=${2:-$store/passwordstore.csv}

[ -d $store ] || {
	echo Directory $store does not exist
	echo
	exit 1
}

echo store : $store
echo csv file : $output
echo

cd $store

rm -i $output

for file in **/*.gpg(.)
do
	fields=(${(@s:/:)file})
	group=${(j:/:)fields[1,-3]}
	title=$fields[-2]
	[ $#group -gt 0 ] || group=$title
	username=${fields[-1]%.gpg}
	password=$(pass show ${file%.gpg})
	lines=(${(f)password})
	password=${(j:-NEWLINE-:)lines}
	password=${password:gs:,:\\\\,}
	if [ $group = sites ]
	then
		url=https://$title
	else
		url=empty
	fi
	tags=empty
	notes=empty
	totp=empty
	icon=empty
	last_modified=empty
	created=$(date +"%A %d %B %Y %H:%M:%S %:z")
	echo file : $file
	echo group : $group
	echo title : $title
	echo username : $username
	#echo password : $password
	echo password : xxx
	echo url : $url
	echo tags : $tags
	echo notes : $notes
	echo totp : $totp
	echo icon : $icon
	echo last_modified : $last_modified
	echo created : $created
	echo
	record="\"$group\",\"$title\",\"$username\",\"$password\",\"$url\",\"$tags\",\"$notes\",\"$totp\",\"$icon\",\"$last_modified\",\"$created\""
	echo $record >>| $output
done

echo "------------------------------------------------------------------------"
echo
echo "DO NOT FORGET TO SAFELY REMOVE"
echo $output
echo "AFTER THE KEEPASSXC IMPORT"
echo
echo "------------------------------------------------------------------------"
echo
