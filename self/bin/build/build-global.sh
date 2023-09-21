#! /usr/bin/env sh

# {{{ Documentation

# `configure' configures GNU GLOBAL 6.5.4 to adapt to many kinds of systems.
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
#   --docdir=DIR            documentation root [DATAROOTDIR/doc/global]
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
#   --enable-silent-rules   less verbose build output (undo: "make V=1")
#   --disable-silent-rules  verbose build output (undo: "make V=0")
#   --enable-dependency-tracking
#                           do not reject slow dependency extractors
#   --disable-dependency-tracking
#                           speeds up one-time build
#   --enable-shared[=PKGS]  build shared libraries [default=yes]
#   --enable-static[=PKGS]  build static libraries [default=yes]
#   --enable-fast-install[=PKGS]
#                           optimize for fast installation [default=yes]
#   --disable-libtool-lock  avoid locking (might break parallel builds)
#   --enable-ltdl-install   install libltdl
#   --disable-gtagscscope   omit gtags-cscope
#
# Optional Packages:
#   --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
#   --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
#   --with-lispdir          override the default lisp directory
#   --with-pic[=PKGS]       try to use only PIC/non-PIC objects [default=use
#                           both]
#   --with-aix-soname=aix|svr4|both
#                           shared library versioning (aka "SONAME") variant to
#                           provide on AIX, [default=aix].
#   --with-gnu-ld           assume the C compiler uses GNU ld [default=no]
#   --with-sysroot[=DIR]    Search for dependent libraries within DIR (or the
#                           compiler's sysroot if not specified).
#   --with-included-ltdl    use the GNU ltdl sources included here
#   --with-ltdl-include=DIR use the ltdl headers installed in DIR
#   --with-ltdl-lib=DIR     use the libltdl.la installed in DIR
#   --with-sco              Use this to turn on SCO-specific code
#   --with-sunos-curses     Used to force SunOS 4.x curses
#   --with-osf1-curses      Used to force OSF/1 curses
#   --with-vcurses=incdir Used to force SysV curses
#   --with-ncurses=dir  Compile with ncurses/locate base dir
#   --with-db185-compat[=DIR] use DB1.85 compatible API included in DB2 or later
#   --with-sqlite3          use sqlite3 API
#   --with-home-etc[=DIR]   include home-etc support [DIR=/usr/local]
#   --with-pread-pwrite     include pread/pwrite support for BSD db library
#   --with-exuberant-ctags=PROGRAM  specify Exuberant Ctags program
#   --with-universal-ctags=PROGRAM  specify Universal Ctags program
#   --with-posix-sort=PROGRAM  specify POSIX sort program
#
# Some influential environment variables:
#   CC          C compiler command
#   CFLAGS      C compiler flags
#   LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
#               nonstandard directory <lib dir>
#   LIBS        libraries to pass to the linker, e.g. -l<library>
#   CPPFLAGS    (Objective) C/C++ preprocessor flags, e.g. -I<include dir> if
#               you have headers in a nonstandard directory <include dir>
#   EMACS       the Emacs editor command
#   EMACSLOADPATH
#               the Emacs library search path
#   PYTHON      the Python interpreter
#   CPP         C preprocessor
#   LT_SYS_LIBRARY_PATH
#               User-defined run-time library search path.
#
# Use these variables to override the choices made by `configure' or to help
# it to find libraries and programs with nonstandard names/locations.
#
# Report bugs to the package provider.
# GNU GLOBAL home page: <http://www.gnu.org/software/global/>.
# General help using GNU software: <http://www.gnu.org/gethelp/>.

# }}}

# {{{ Prérequis

# automake autoconf gperf bison flex
# perl ncurses libtool

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

#make distclean

# }}}

# {{{ Préconfig

sh reconf.sh

# }}}

# {{{ Configure

# Attention à ne pas mettre de commentaire
# entre deux lignes, sinon le shell croit
# qu'il s'agit de la commande suivante

./configure \
	--prefix=/usr/local \
	--with-exuberant-ctags=/bin/ctags


# }}}

# {{{ Make

make

# }}}

# {{{ Restauration

export CFLAGS=$sauve_cflags

export LDFLAGS=$sauve_ldflags

export PATH=$sauve_path

# }}}
