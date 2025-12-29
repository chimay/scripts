#!/usr/bin/env zsh

# usage {{{1

[ $# -eq 0 ] && {
	echo Usage : ${0##*/} '+source_extension [+source_extension ...] -target_extension [-target_extension ...]'
	echo
	echo A target is to be removed it any of the sources extensions is absent
	exit 0
}

# arguments {{{1

sources_list=()
targets_list=()

while true
do
	case $1 in
		+?*)
			sources_list+=${1[2,$]}
			shift
			;;
		-?*)
			targets_list+=${1[2,$]}
			shift
			;;
		*)
			break
			;;
	esac
done

echo
echo sources_list :
echo
print -l $sources_list
echo
echo targets_list :
echo
print -l $targets_list
echo

# loop {{{1

toberemoved=()

for target_ext in $targets_list
do
	echo '----> ' analyzing target extension : $target_ext
	echo
	for target in *.$target_ext
	do
		rootname=${target%.*}
		#echo $rootname
		for source_ext in $sources_list
		do
			doyouexist=$rootname.$source_ext
			#echo $doyouexist
			if [ ! -f $doyouexist ]
			then
				toberemoved+=$target
			fi
		done
	done
done

if [ $#toberemoved -gt 0 ]
then
	echo
	echo to be removed :
	echo
	print -l $toberemoved
	echo
	echo -n "proceed ? (y/n) "
	read answer
	[ +$answer = +y ] || [ +$answer = +yes ] && {
		rm -f $toberemoved
	}
else
	echo directory is clear, no obsolete target to remove
fi

