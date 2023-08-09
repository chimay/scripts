#! /usr/bin/env zsh

linksfile=$1

linklist=()
targetlist=()

while read line
do
	# -- fields
	fields=(${(s/	/)line})
	# -- link
	link=$~fields[1]
	link=${(e)link}
	# -- target
	target=$~fields[2]
	target=${(e)target}
	# -- lists
	linklist+=($link)
	targetlist+=($target)
done < $linksfile

# echo $#linklist $#targetlist
# print -l $linklist
# echo
# print -l $targetlist
# exit 0

[ $#linklist -eq $#targetlist ] || {
	echo 'link and target list are not of the same length'
	exit 1
}

length=$#linklist

for index in {1..$length}
do
	link=$linklist[$index]
	target=$targetlist[$index]
	# -- empty ?
	[ $#link -eq 0 ] && {
		echo 'link is empty'
		continue
	}
	[ $#target -eq 0 ] && {
		echo 'target is empty'
		continue
	}
	# -- link exists ?
	[ -L $link ] && {
		#echo link $link already exists
		curtarget=$(readlink $link)
		[ $target != $curtarget ] && {
			echo link $link points to wrong target '->' $curtarget
			echo -n 'overwrite ? (y/[N]) '
			read answer
			[ $#answer -eq 0 ] && answer=no
			[[ $answer = y* ]] && {
				echo "rm -f $link"
				rm -f $link
				echo "ln -sf $target $link"
				ln -sf $target $link
			}
		}
		continue
	}
	[ -f $link ] && {
		echo file $link already exists
		continue
	}
	[ -d $link ] && {
		echo directory $link already exists
		continue
	}
	[ -e $link ] && {
		echo $link already exists
		continue
	}
	# -- link dir exists ?
	linkdir=${link%/*}
	if ! [ -d $linkdir ]
	then
		[ -e $linkdir ] && {
			echo $linkdir already exists but is not a dir
			echo -n 'delete it ? (y/[N]) '
			read answer
			[ $#answer -eq 0 ] && answer=no
			[[ $answer = n* ]] && continue
			echo "rm -f $linkdir"
			rm -f $linkdir
		}
		echo "mkdir -p $linkdir"
		mkdir -p $linkdir
	fi
	# -- linking
	echo "ln -sf $target $link"
	ln -sf $target $link
done

echo

for index in {1..$length}
do
	link=$linklist[$index]
	[ -L $link ] || {
		echo $link is not a link
		continue
	}
	target=$targetlist[$index]
	[ -e $target ] || {
		echo broken : $link '->' $target
		continue
	}
done
