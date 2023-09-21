#! /usr/bin/env sh

#  {{{ Options gcc
# ------------------------------------------------------------------------

pythonlib="/usr/include/python2.6"

include="-I$pythonlib"

# Pour options de gcc génériques
# ------------------------------------

#if (( ${#CFLAGS} == 0 ))
#then
    #echo "Environnement : CFLAGS vide ==> on le remplit"

	#drapeaux="-O2 -march=native -mtune=native"
	#drapeaux="$drapeaux -pthread -fPIC -fwrapv -fno-strict-aliasing"
	#drapeaux="$drapeaux -Wall -Wstrict-prototypes"
#else
	#drapeaux=$CFLAGS
#fi

# Les options pour gcc
# sont particulières au script
# ------------------------------------

drapeaux="-O2 -march=native -mtune=native"
drapeaux="$drapeaux -pthread -fPIC -fwrapv -fno-strict-aliasing"
drapeaux="$drapeaux -Wall -Wstrict-prototypes"

drapeaux="-v $drapeaux"

libs="-lpython2.6 -lpthread -lm -lutil -ldl"

# "... ... ..." --> "..." "..." "..."
# -OU- (z)
# -OU- setopt sh_word_split

drapeaux=${(z)drapeaux}
libs=${(z)libs}

# }}}

#  {{{ Cible
# ------------------------------------------------------------------------

cible="modules"

case $1 in
	mod*)
		cible="modules"
		;;
	app*)
		cible="application"
		;;
esac

# }}}

#  {{{ Compilation
# ------------------------------------------------------------------------

if [[ $cible = "modules" ]]
then

	cython *.pyx

	for fichier in *.c
	do
		mod=${fichier%.*}

		echo gcc -shared $drapeaux $include -o ${mod}.so ${mod}.c

		gcc -shared $drapeaux $include -o ${mod}.so ${mod}.c
	done

elif [[ $cible = "application" ]]
then

	shift

	app=${1%%.*}

	cython --embed ${app}.pyx

	echo gcc $drapeaux $include -o ${app}.elf ${app}.c $libs

	gcc $drapeaux $include -o ${app}.elf ${app}.c $libs

fi

# }}}
