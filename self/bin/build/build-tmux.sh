#! /usr/bin/env sh

# {{{ Documentation

# `configure' configures tmux 1.9 to adapt to many kinds of systems.
# 
# Usage: ./configure [OPTION]... [VAR=VALUE]...
# 
# To assign environment variables (e.g., CC, CFLAGS...), specify them as
# VAR=VALUE.  See below for descriptions of some of the useful variables.
# 
# Defaults for the options are specified in brackets.
# 
# Configuration:
#   -h, --help              display this help and exit
#       --help=short        display options specific to this package
#       --help=recursive    display the short help of all the included packages
#   -V, --version           display version information and exit
#   -q, --quiet, --silent   do not print `checking ...' messages
#       --cache-file=FILE   cache test results in FILE [disabled]
#   -C, --config-cache      alias for `--cache-file=config.cache'
#   -n, --no-create         do not create output files
#       --srcdir=DIR        find the sources in DIR [configure dir or `..']
# 
# Installation directories:
#   --prefix=PREFIX         install architecture-independent files in PREFIX
#                           [/usr/local]
#   --exec-prefix=EPREFIX   install architecture-dependent files in EPREFIX
#                           [PREFIX]
# 
# By default, `make install' will install all the files in
# `/usr/local/bin', `/usr/local/lib' etc.  You can specify
# an installation prefix other than `/usr/local' using `--prefix',
# for instance `--prefix=$HOME'.
# 
# For better control, use the options below.
# 
# Fine tuning of the installation directories:
#   --bindir=DIR            user executables [EPREFIX/bin]
#   --sbindir=DIR           system admin executables [EPREFIX/sbin]
#   --libexecdir=DIR        program executables [EPREFIX/libexec]
#   --sysconfdir=DIR        read-only single-machine data [PREFIX/etc]
#   --sharedstatedir=DIR    modifiable architecture-independent data [PREFIX/com]
#   --localstatedir=DIR     modifiable single-machine data [PREFIX/var]
#   --libdir=DIR            object code libraries [EPREFIX/lib]
#   --includedir=DIR        C header files [PREFIX/include]
#   --oldincludedir=DIR     C header files for non-gcc [/usr/include]
#   --datarootdir=DIR       read-only arch.-independent data root [PREFIX/share]
#   --datadir=DIR           read-only architecture-independent data [DATAROOTDIR]
#   --infodir=DIR           info documentation [DATAROOTDIR/info]
#   --localedir=DIR         locale-dependent data [DATAROOTDIR/locale]
#   --mandir=DIR            man documentation [DATAROOTDIR/man]
#   --docdir=DIR            documentation root [DATAROOTDIR/doc/tmux]
#   --htmldir=DIR           html documentation [DOCDIR]
#   --dvidir=DIR            dvi documentation [DOCDIR]
#   --pdfdir=DIR            pdf documentation [DOCDIR]
#   --psdir=DIR             ps documentation [DOCDIR]
# 
# Program names:
#   --program-prefix=PREFIX            prepend PREFIX to installed program names
#   --program-suffix=SUFFIX            append SUFFIX to installed program names
#   --program-transform-name=PROGRAM   run sed PROGRAM on installed program names
# 
# System types:
#   --build=BUILD     configure for building on BUILD [guessed]
#   --host=HOST       cross-compile to build programs to run on HOST [BUILD]
# 
# Optional Features:
#   --disable-option-checking  ignore unrecognized --enable/--with options
#   --disable-FEATURE       do not include FEATURE (same as --enable-FEATURE=no)
#   --enable-FEATURE[=ARG]  include FEATURE [ARG=yes]
#   --disable-dependency-tracking  speeds up one-time build
#   --enable-dependency-tracking   do not reject slow dependency extractors
#   --enable-debug          create a debug build
#   --enable-static         create a static build
# 
# Some influential environment variables:
#   CC          C compiler command
#   CFLAGS      C compiler flags
#   LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
#               nonstandard directory <lib dir>
#   LIBS        libraries to pass to the linker, e.g. -l<library>
#   CPPFLAGS    (Objective) C/C++ preprocessor flags, e.g. -I<include dir> if
#               you have headers in a nonstandard directory <include dir>
#   CPP         C preprocessor
#   PKG_CONFIG  path to pkg-config utility
#   PKG_CONFIG_PATH
#               directories to add to pkg-config's search path
#   PKG_CONFIG_LIBDIR
#               path overriding pkg-config's built-in search path
#   LIBEVENT_CFLAGS
#               C compiler flags for LIBEVENT, overriding pkg-config
#   LIBEVENT_LIBS
#               linker flags for LIBEVENT, overriding pkg-config
# 
# Use these variables to override the choices made by `configure' or to help
# it to find libraries and programs with nonstandard names/locations.
# 
# Report bugs to the package provider.

# }}}

# {{{ Environnement

sauve_cflags=$CFLAGS

export CFLAGS=

sauve_ldflags=$LDFLAGS

export LDFLAGS=

sauve_path=$PATH

export PATH=/bin:/usr/bin:/usr/local/bin:/sbin

# }}}

# {{{ Préconfig

#sh autogen.sh

# }}}

# {{{ Clean

make clean
make distclean

# }}}

# {{{ Configure

# Attention à ne pas mettre de commentaire
# entre deux lignes, sinon le shell croit
# qu'il s'agit de la commande suivante

./configure \
	--prefix=/usr/local

# }}}

# {{{ Make

make

# }}}

# {{{ Restauration

export CFLAGS=$sauve_cflags

export LDFLAGS=$sauve_ldflags

export PATH=$sauve_path

# }}}
