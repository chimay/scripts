#! /usr/bin/env sh

# {{{ Environnement

sauve_cflags=$CFLAGS

export CFLAGS=

sauve_ldflags=$LDFLAGS

export LDFLAGS=

sauve_path=$PATH

export PATH=/bin:/usr/bin:/usr/local/bin:/sbin

# }}}

# {{{ Clean

make clean

# }}}

# {{{ Preconfigure

autoreconf -i

#sed -i 's|MUGDIR|"/usr/share/pixmaps"|' toys/mug/mug.c

# }}}

# {{{ Configure

./configure --prefix=/usr/local --disable-webkit --disable-gtk --enable-mu4e

# }}}

# {{{ Make

make

# }}}

# {{{ Restauration

export CFLAGS=$sauve_cflags

export LDFLAGS=$sauve_ldflags

export PATH=$sauve_path

# }}}
