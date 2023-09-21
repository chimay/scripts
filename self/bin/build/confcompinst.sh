#! /usr/bin/env sh
# Compile et installe les sources d'un paquetage

./configure --prefix=/usr/local && make && su -c "make install"
