#!/usr/bin/env zsh

# put the pass (passwordstore) database in csv format
# can then be imported in keepass

store=${1:-~/.password-store}

output=passwordstore.csv

cd $store

rm -i $output

for file in **/*(.)
do
	fields=(${(@s:/:)file})
	group=${(j:/:)fields[1,-3]}
	title=$fields[-2]
	[ $#group -gt 0 ] || group=$title
	username=${fields[-1]%.gpg}
	password=$(pass show ${file%.gpg})
	lines=(${(f)password})
	password=${(j:-NEWLINE-:)lines}
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
	echo password : $password
	echo url : $url
	echo tags : $tags
	echo notes : $notes
	echo totp : $totp
	echo icon : $icon
	echo last_modified : $last_modified
	echo created : $created
	echo
	record="$group,$title,$username,$password,$url,$tags,$notes,$totp,$icon,$last_modified,$created"
	echo $record >>| $output
done

echo "Don't forget to safely remove ~/.password-store/passwordstore.csv"
echo
