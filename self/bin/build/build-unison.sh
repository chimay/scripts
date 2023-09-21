#! /usr/bin/env sh

# {{{ Prérequis

# sudo apt install ocaml liblablgtk2-ocaml

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

make clean

# }}}

# {{{ Préconfig

#./autogen.sh all

# }}}

# {{{ Configure

# Attention à ne pas mettre de commentaire
# entre deux lignes, sinon le shell croit
# qu'il s'agit de la commande suivante

# ./configure \
# 	--prefix=/usr/local

# }}}

# {{{ Make

make UISTYLE=text

echo "sudo cp ./src/unison /usr/local/bin"
echo

# }}}

# {{{ Restauration

export CFLAGS=$sauve_cflags

export LDFLAGS=$sauve_ldflags

export PATH=$sauve_path

# }}}
