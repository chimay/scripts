#! /usr/bin/env sh

# {{{ Prérequis

# sudo apt-get build-dep herbstluftwm

# }}}

# {{{ Clean

make cleandeps
make clean

# }}}

# {{{ Make

make PREFIX=/usr/local

# }}}
