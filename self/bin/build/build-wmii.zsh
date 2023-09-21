#! /usr/bin/env sh

# {{{ Prérequis

# sudo aptitude install txt2tags

# Ajouter : -ldl à la ligne :
#
# [ -n "$PACKAGES" ] && LDFLAGS="$LDFLAGS $(pkg-config --libs $PACKAGES) -ldl"
#
# dans :
#
# util/link

# }}}

# {{{ Clean

cd ~/source/winman/libixp

make clean

cd ~/source/winman/wmii

make clean

# }}}

# {{{ Librairies

cd ~/source/winman/libixp

make

sudo make install

# }}}

# {{{ Make

cd ~/source/winman/wmii

make

sudo make install

# }}}
