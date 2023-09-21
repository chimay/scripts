#! /usr/bin/env sh

# {{{ Prérequis

# sudo aptitude build-dep xmonad
# sudo aptitude install cabal-install libxft-dev

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

./configure

# }}}

# {{{ Make

#make
#make check
#sudo make install

# }}}
