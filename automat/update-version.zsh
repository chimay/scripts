#! /usr/bin/env zsh

setopt null_glob

date +" [=] %A %d %B %Y  (o) %H:%M  | %:z | "

directory=${1:-.}

cd $directory

# {{{ Git

for folder in */.git(:h)
do
	echo ""
	echo "------------------------------------"
	echo ""

	echo "cd $folder"
	echo
	echo "git pull"

	cd $folder

	git pull || { git fetch --all && git reset --hard origin/master }

	cd -
done

# }}}

# {{{ Mercurial

for folder in */.hg(:h)
do
	echo ""
	echo "------------------------------------"
	echo ""

	echo "cd $folder"
	echo
	echo "hg pull ; hg update"

	cd $folder

	hg pull ; hg update

	cd -
done

# }}}

# {{{ Bazaar

for folder in */.bzr(:h)
do
	echo ""
	echo "------------------------------------"
	echo ""

	echo "cd $folder"
	echo
	echo "bzr pull ; bzr update"

	cd $folder

	bzr pull ; bzr update

	cd -
done

# }}}

# {{{ Concurrent Version System

for folder in */CVS(:h)
do
	echo ""
	echo "------------------------------------"
	echo ""

	echo "cd $folder"
	echo
	echo "cvs up"

	cd $folder

	cvs up

	cd -
done

# }}}

	echo ""
	echo "===================================="
	echo ""
