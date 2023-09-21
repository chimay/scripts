#! /usr/bin/env sh

# {{{ Documentation

# }}}

# {{{ Prérequis

# sudo aptitude build-dep weechat

# }}}

# {{{ Préconfig

cd ~/source/chaton/weechat

[ -d build ] || mkdir build

cd build

# }}}

# {{{ Clean

make clean

# }}}

# {{{ Config

cmake .. -DPREFIX=/usr/local -DCMAKE_BUILD_TYPE=Debug

#cmake .. -DPREFIX=/usr/local

# }}}

# {{{ Make

#make
#sudo make install

# }}}
