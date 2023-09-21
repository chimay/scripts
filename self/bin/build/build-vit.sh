#! /usr/bin/env sh

argument=$1

# {{{ Documentation



# {{{ Prérequis



# }}}

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

# }}}

# {{{ Préconfig



# }}}

# {{{ Configure

./configure --prefix=/usr/local

# }}}

# {{{ Make

make

# }}}

# {{{ Restauration

export CFLAGS=$sauve_cflags

export LDFLAGS=$sauve_ldflags

export PATH=$sauve_path

# }}}
