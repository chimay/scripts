#! /usr/bin/env sh

# {{{ Documentation

# `configure' configures this package to adapt to many kinds of systems.
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
#   --docdir=DIR            documentation root [DATAROOTDIR/doc/PACKAGE]
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
#   --enable-cppflags=...   specify C preprocessor flags
#   --enable-cflags=...     specify C compiler flags
#   --enable-ldflags=...    specify linker flags
#   --enable-libs=...       specify link libraries
#   --enable-zsh-debug      compile with debug code and debugger symbols
#   --enable-zsh-mem        compile with zsh memory allocation routines
#   --enable-zsh-mem-debug  debug zsh memory allocation routines
#   --enable-zsh-mem-warning
#                           print warnings for errors in memory allocation
#   --enable-zsh-secure-free
#                           turn on error checking for free()
#   --enable-zsh-heap-debug turn on error checking for heap allocation
#   --enable-zsh-valgrind   turn on support for valgrind debugging of heap
#                           memory
#   --enable-zsh-hash-debug turn on debugging of internal hash tables
#   --enable-stack-allocation
#                           allocate stack memory e.g. with `alloca'
#   --enable-etcdir=DIR     the default directory for global zsh scripts
#   --enable-zshenv=FILE    the full pathname of the global zshenv script
#   --enable-zshrc=FILE     the full pathname of the global zshrc script
#   --enable-zprofile=FILE  the full pathname of the global zprofile script
#   --enable-zlogin=FILE    the full pathname of the global zlogin script
#   --enable-zlogout=FILE   the full pathname of the global zlogout script
#   --disable-dynamic       turn off dynamically loaded binary modules
#   --disable-restricted-r  turn off r* invocation for restricted shell
#   --disable-locale        turn off locale features
#   --enable-ansi2knr       translate source to K&R C before compiling
#   --enable-runhelpdir=DIR the directory in which to install run-help files
#   --enable-fndir=DIR      the directory in which to install functions
#   --enable-site-fndir=DIR same for site functions (not version specific)
#   --enable-function-subdirs
#                           install functions in subdirectories
#   --enable-additional-fpath=DIR
#                           add directories to default function path
#   --enable-scriptdir=DIR  the directory in which to install scripts
#   --enable-site-scriptdir=DIR
#                           same for site scripts (not version specific)
#   --enable-custom-patchlevel
#                           set a custom ZSH_PATCHLEVEL value
#   --enable-maildir-support
#                           enable maildir support in MAIL and MAILPATH
#   --enable-max-function-depth=MAX
#                           limit function depth to MAX, default 1000
#   --enable-readnullcmd=PAGER
#                           pager used when READNULLCMD is not set
#   --enable-pcre           enable the search for the pcre library (may create
#                           run-time library dependencies)
#   --enable-cap            enable the search for POSIX capabilities (may
#                           require additional headers to be added by hand)
#   --disable-gdbm          turn off search for gdbm library
#   --disable-largefile     omit support for large files
#   --enable-multibyte      support multibyte characters
#   --enable-libc-musl      compile with musl as the C library
#   --disable-dynamic-nss   do not call functions that will require dynamic NSS
#                           modules
#
# Optional Packages:
#   --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
#   --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
#   --with-term-lib=LIBS    search space-separated LIBS for terminal handling
#   --with-tcsetpgrp        assumes that tcsetpgrp() exists and works correctly
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
#
# Use these variables to override the choices made by `configure' or to help
# it to find libraries and programs with nonstandard names/locations.
#
# Report bugs to the package provider.

# }}}

# {{{ Prérequis

# sudo aptitude buildep zsh

# sudo aptitude install yodl

# }}}

# {{{ Environnement

sauve_cflags=$CFLAGS

export CFLAGS=

sauve_ldflags=$LDFLAGS

export LDFLAGS=

sauve_path=$PATH

export PATH=/bin:/usr/bin:/usr/local/bin:/sbin

# }}}

# {{{ Preconfig

# Si le fichier configure n’existe pas encore

[ -e configure ] || ./Util/preconfig

# }}}

# {{{ Clean

make clean
#make distclean

# }}}

# {{{ Configuration

# Attention à ne pas mettre de commentaire
# entre deux lignes, sinon le shell croit
# qu'il s'agit de la commande suivante

./configure \
	--prefix=/usr/local \
	--enable-multibyte

# }}}

# {{{ Make

make
#make check
#sudo make install

# }}}

# {{{ Restauration

export CFLAGS=$sauve_cflags

export LDFLAGS=$sauve_ldflags

export PATH=$sauve_path

# }}}
