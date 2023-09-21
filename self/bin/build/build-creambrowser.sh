#! /usr/bin/env sh

# {{{ Documentation

# Usage: ./build.sh [options...]
#
# Options:
#      --prefix=<PREFIX>            Use PREFIX for installation (default: /usr)
#      --sysconfdir=<SYSCONFDIR>    Use SYSCONFDIR for configuration installation (default: /etc
#      --enable-vte                 Enable VTE Terminal support (if present)
#      --disable-vte                Disable VTE Terminal support (even if present)
#      --help                       Print this message

# }}}

# {{{ Préconfig

# Nécessaire dans certains dépôts pour générer le fichier configure

#sh autogen.sh

# }}}

# {{{ Clean

make clean
make distclean

# }}}

# {{{ Configure

# Prérequis :
#
# sudo aptitude install cmake
# sudo aptitude install libwebkit-dev libconfuse-dev libvte-dev

# Attention à ne pas mettre de commentaire
# entre deux lignes, sinon le shell croit
# qu'il s'agit de la commande suivante

./build.sh \
	--prefix=/usr/local \
	--enable-vte

# }}}

# {{{ Make

#make
#make check
#sudo make install

# }}}
