#! /usr/bin/env zsh

cd $HOME
[ -d .config ] || mkdir -p .config
[ -d .local/share ] || mkdir -p .local/share

linksfile=${1:-~/racine/self/links/racine-links.txt}

linklist=()
targetlist=()

while read line
do
	# -- fields
	fields=(${(s/	/)line})
	link=$~fields[1]
	target=$~fields[2]
	# -- link
	link=${link//\$HOME/$HOME}
	link=${link//\$HOST/$HOST}
	# -- target
	target=${target//\$HOME/$HOME}
	target=${target//\$HOST/$HOST}
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
	# -- exists ?
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
	# -- linking
	echo "ln -sf $target $link"
	ln -sf $target $link
done
