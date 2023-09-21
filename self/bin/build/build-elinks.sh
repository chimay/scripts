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
# X features:
#   --x-includes=DIR    X include files are in DIR
#   --x-libraries=DIR   X library files are in DIR
#
# System types:
#   --build=BUILD     configure for building on BUILD [guessed]
#   --host=HOST       cross-compile to build programs to run on HOST [BUILD]
#
# Optional Features:
#   --disable-option-checking  ignore unrecognized --enable/--with options
#   --disable-FEATURE       do not include FEATURE (same as --enable-FEATURE=no)
#   --enable-FEATURE[=ARG]  include FEATURE [ARG=yes]
#   --disable-largefile     omit support for large files
#   --disable-bookmarks     disable bookmark support
#   --disable-xbel          disable XBEL bookmark support (requires expat)
#   --disable-sm-scripting  ECMAScript browser scripting (requires Spidermonkey)
#   --disable-nls           do not use Native Language Support
#   --disable-cookies       disable cookie support
#   --disable-formhist      disable form history support
#   --disable-globhist      disable global history support
#   --disable-mailcap       disable mailcap support
#   --disable-mimetypes     disable mimetypes files support
#   --disable-ipv6          disable IPv6 support
#   --enable-bittorrent     enable BitTorrent protocol support
#   --disable-data          disable data protocol support
#   --disable-uri-rewrite   disable URI rewrite support
#   --enable-cgi            enable local CGI support
#   --enable-finger         enable finger protocol support
#   --enable-fsp            enable FSP protocol support
#   --disable-ftp           disable ftp protocol support
#   --enable-gopher         enable gopher protocol support
#   --enable-nntp           enable nntp protocol support
#   --enable-smb            enable Samba protocol support
#   --disable-mouse         disable mouse support
#   --disable-sysmouse      disable BSD sysmouse support
#   --enable-88-colors      enable 88 color support
#   --enable-256-colors     enable 256 color support
#   --enable-true-color     enable true color support
#   --enable-exmode         enable exmode (CLI) interface
#   --disable-leds          disable LEDs support
#   --disable-marks         disable document marks support
#   --disable-css           disable Cascading Style Sheet support
#   --enable-html-highlight HTML highlighting using DOM engine
#   --disable-backtrace     disable backtrace support
#   --enable-no-root        enable prevention of usage by root
#   --enable-debug          enable leak debug and internal error checking
#   --enable-fastmem        enable direct use of system allocation functions, not usable with --enable-debug
#   --enable-own-libc       force use of internal functions instead of those of system libc
#   --enable-small          reduce binary size as far as possible (but see the bottom of doc/small.txt!)
#   --disable-utf-8         disable UTF-8 support
#   --enable-combining      support Unicode combining characters (experimental)
#
#     Also check out the features.conf file for more information about features!
#
#
# Optional Packages:
#   --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
#   --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
#   --with-xterm            how to invoke the X terminal emulator
#   --without-gpm           disable gpm (mouse) support
#   --without-zlib          disable zlib support
#   --without-bzlib         disable bzlib support
#   --without-idn           disable international domain names support
#   --with-gc               enable Boehm's garbage collector
#   --with-lzma             enable lzma encoding support
#   --with-gssapi           enable GSSAPI support
#   --without-spidermonkey  disable SpiderMonkey Mozilla JavaScript engine
#                           support
#   --with-guile            enable Guile support
#   --with-perl             enable Perl support
#   --with-python[=DIR]     enable Python support
#   --without-lua           disable Lua support
#   --without-tre           disable TRE regex search support
#   --with-ruby             enable Ruby support
#   --without-gnutls        disable GNUTLS SSL support
#   --with-gnutls           enable GNUTLS SSL support
#   --without-openssl       disable OpenSSL support
#   --with-openssl[=DIR]    enable OpenSSL support (default)
#   --with-nss_compat_ossl[=DIR]
#                           NSS compatibility SSL libraries/include files
#   --with-x                use the X Window System
#   --with-libiconv=DIR     search for libiconv in DIR/include and DIR/lib
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
#   XMKMF       Path to xmkmf, Makefile generator for X Window System
#
# Use these variables to override the choices made by `configure' or to help
# it to find libraries and programs with nonstandard names/locations.
#
# Report bugs to the package provider.

# }}}

# {{{ Prérequis

# sudo aptitude build-dep elinks
# sudo aptitude install liblzma-dev guile-1.8-dev libssl-dev libgc-dev libgc1c2

# Instructions :
#
# enlever le -Werror du Makefile.config

# }}}

# {{{ Clean

make clean
make distclean

# }}}

# {{{ Configuration

# Attention à ne pas mettre de commentaire
# entre deux lignes, sinon le shell croit
# qu'il s'agit de la commande suivante

./configure \
	--prefix=/usr/local \
	--enable-88-colors \
	--enable-256-colors \
	--enable-true-color \
	--enable-exmode \
	--enable-cgi \
	--enable-bittorrent \
	--enable-fsp \
	--enable-ftp \
	--enable-nntp \
	--enable-finger \
	--enable-gopher \
	--enable-smb \
	--with-perl \
	--with-ruby \
	--with-gc=/usr/include/gc

	# Fait planter la compilation
# 	--enable-lzma \

	# Provoque l’erreur :
	# ImportWarning: Not importing directory 'site': missing __init__.py
# 	--with-python \

# }}}

# {{{ Make

#make
#make check
#sudo make install

# }}}
