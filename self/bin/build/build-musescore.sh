#! /usr/bin/env sh

# /!\ Sur shari, ne pas oublier d’ajouter :
#
# CPUS := 1
#
# dans le Makefile
#
# sinon, chauffe beaucoup
#
# ouais, chauffe quand même trop

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

# {{{ Make

make release

# }}}

# {{{ Restauration

export CFLAGS=$sauve_cflags

export LDFLAGS=$sauve_ldflags

export PATH=$sauve_path

# }}}
