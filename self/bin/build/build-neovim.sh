#! /usr/bin/env sh

# {{{ Prérequis

# sudo pacman -S base-devel cmake extra-cmake-modules ninja ncurses pkg-config luajit lua-lpeg lua-messagepack
# libtool-bin

# }}}

# {{{ Environnement

sauve_cflags=$CFLAGS

export CFLAGS=

sauve_ldflags=$LDFLAGS

export LDFLAGS=

sauve_path=$PATH

export PATH=/bin:/usr/bin:/usr/local/bin:/sbin

# }}}

# {{{ Clean

#make clean

make distclean

# }}}

# {{{ Préconfig

#make cmake

# }}}

# {{{ Make

make

# }}}

# {{{ Restauration

export CFLAGS=$sauve_cflags

export LDFLAGS=$sauve_ldflags

export PATH=$sauve_path

# }}}
