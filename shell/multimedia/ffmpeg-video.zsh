#! /usr/bin/env zsh

# vim: set conceallevel=0 :

format=$1

shift

if false
then
	:

# {{{ AVI

elif [ $format = "avi" ]
then

	for entree in "$@"
	do
		sortie=${entree%.*}.$format

		echo "mencoder $entree \
			-alang fr -slang none \
			-oac mp3lame -lameopts br=320:cbr \
			-ovc lavc -lavcopts vcodec=mpeg4:vhq \
			-vf scale -zoom -xy 800 \
			-o $sortie.avi"

		mencoder $entree \
			-alang fr -slang none \
			-oac mp3lame -lameopts br=320:cbr \
			-ovc lavc -lavcopts vcodec=mpeg4:vhq \
			-vf scale -zoom -xy 800 \
			-o $sortie.avi
	done

# }}}

fi
