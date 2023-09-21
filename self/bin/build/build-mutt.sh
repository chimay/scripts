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
#   --disable-dependency-tracking  speeds up one-time build
#   --enable-dependency-tracking   do not reject slow dependency extractors
#   --disable-largefile     omit support for large files
#   --enable-gpgme          Enable GPGME support
#   --disable-pgp           Disable PGP support
#   --disable-smime         Disable SMIME support
#   --enable-external-dotlock
#                           Force use of an external dotlock program
#   --enable-pop            Enable POP3 support
#   --enable-imap           Enable IMAP support
#   --enable-smtp           include internal SMTP relay support
#   --enable-debug          Enable debugging support
#   --enable-flock          Use flock() to lock files
#   --disable-fcntl         Do NOT use fcntl() to lock files
#   --disable-warnings      Turn off compiler warnings (not recommended)
#   --enable-nfs-fix        Work around an NFS with broken attributes caching
#   --enable-mailtool       Enable Sun mailtool attachments support
#   --enable-locales-fix    The result of isprint() is unreliable
#   --enable-exact-address  Enable regeneration of email addresses
#   --enable-hcache         Enable header caching
#   --disable-iconv         Disable iconv support
#   --disable-nls           Do not use Native Language Support
#   --disable-full-doc      Omit disabled variables
#
# Optional Packages:
#   --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
#   --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
#   --with-gpgme-prefix=PFX prefix where GPGME is installed (optional)
#   --with-mixmaster[=PATH] Include Mixmaster support
#   --with-slang[=DIR]      Use S-Lang instead of ncurses
#   --with-curses=DIR       Where ncurses is installed
#   --with-regex            Use the GNU regex library
#   --with-homespool[=FILE] File in user's directory where new mail is spooled
#   --with-mailpath=DIR     Directory where spool mailboxes are located
#   --with-docdir=PATH      Specify where to put the documentation
#   --with-domain=DOMAIN    Specify your DNS domain name
#   --with-gss[=PFX]        Compile in GSSAPI authentication for IMAP
#   --with-ssl[=PFX]        Enable TLS support using OpenSSL
#   --with-gnutls[=PFX]     enable TLS support using gnutls
#   --with-sasl[=PFX]       Use SASL network security library
#   --with-exec-shell=SHELL Specify alternate shell (ONLY if /usr/bin/env sh is broken)
#   --without-tokyocabinet  Don't use tokyocabinet even if it is available
#   --without-qdbm          Don't use qdbm even if it is available
#   --without-gdbm          Don't use gdbm even if it is available
#   --with-bdb[=DIR]        Use BerkeleyDB4 if gdbm is not available
#   --with-libiconv-prefix[=DIR]
#                           Search for libiconv in DIR/include and DIR/lib
#   --with-included-gettext Use the GNU gettext library included here
#   --with-idn=[PFX]        Use GNU libidn for domain names
#   --without-wc-funcs      Do not use the system's wchar_t functions
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

# sudo aptitude build-dep mutt

# }}}

# {{{ Préconfig

# ./prepare contient :

# #! /usr/bin/env sh
#
# if autoreconf --install && ./configure "$@"
# then
#   echo
#   echo "The mutt source code was successfully prepared and configured."
#   echo "Type   make && make install   to build and install mutt."
#   echo
# else
#   echo
#   echo "Some part of the preparation process failed."
#   echo "Please refer to doc/devel-notes.txt for details."
#   echo
#   exit 1
# fi

#autoreconf --install

# }}}

# {{{ Clean

#make clean
#make distclean

# }}}

# {{{ Configuration

# Attention à ne pas mettre de commentaire
# entre deux lignes, sinon le shell croit
# qu'il s'agit de la commande suivante

./configure \
	--prefix=/usr/local \
	--enable-pop \
	--enable-imap \
	--enable-smtp \
	--enable-hcache \
	--enable-exact-address \
	--enable-mailtool \
	--enable-gpgme \
	--enable-flock \
	--enable-nfs-fix \
	--enable-locales-fix \
	--with-gnutls \
	--with-mixmaster \
	--with-regex \
	--with-sasl \
	--with-ssl

# }}}

# {{{ Make

#make
#make check
#sudo make install

# }}}
