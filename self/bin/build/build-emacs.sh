#! /usr/bin/env sh

# {{{ Documentation

# `configure' configures GNU Emacs 25.1.50 to adapt to many kinds of systems.
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
#   --docdir=DIR            documentation root [DATAROOTDIR/doc/emacs]
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
#   --enable-silent-rules   less verbose build output (undo: "make V=1")
#   --disable-silent-rules  verbose build output (undo: "make V=0")
#   --disable-ns-self-contained
#                           disable self contained build under NeXTstep
#   --enable-locallisppath=PATH
#                           directories Emacs should search for lisp files
#                           specific to this site
#   --enable-checking[=LIST]
#                           enable expensive run-time checks. With LIST, enable
#                           only specific categories of checks. Categories are:
#                           all,yes,no. Flags are: stringbytes, stringoverrun,
#                           stringfreelist, xmallocoverrun, conslist, glyphs
#   --enable-check-lisp-object-type
#                           enable compile time checks for the Lisp_Object data
#                           type. This is useful for development for catching
#                           certain types of bugs.
#   --enable-profiling      build emacs with low-level, gprof profiling support.
#                           Mainly useful for debugging Emacs itself. May not
#                           work on all platforms. Stops profiler.el working.
#   --enable-autodepend     automatically generate dependencies to .h-files.
#                           Requires gcc, enabled if found.
#   --enable-gtk-deprecation-warnings
#                           Show Gtk+/Gdk deprecation warnings for Gtk+ >= 3.0
#   --disable-build-details Make the build more deterministic by omitting host
#                           names, time stamps, etc. from the output.
#   --enable-dependency-tracking
#                           do not reject slow dependency extractors
#   --disable-dependency-tracking
#                           speeds up one-time build
#   --disable-largefile     omit support for large files
#   --enable-gcc-warnings[=TYPE]
#                           control generation of GCC warnings. The TYPE 'yes'
#                           means to fail if any warnings are issued;
#                           'warn-only' means issue warnings without failing
#                           (default for developer builds); 'no' means disable
#                           warnings (default for non-developer builds).
#   --enable-link-time-optimization
#                           build emacs with link-time optimization. This
#                           requires GCC 4.5.0 or later, or clang. (Note that
#                           clang support is experimental - see INSTALL.) It
#                           also makes Emacs harder to debug, and when we tried
#                           it with GCC 4.9.0 x86-64 it made Emacs slower, so
#                           it's not recommended for typical use.
#   --disable-acl           do not support ACLs
#
# Optional Packages:
#   --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
#   --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
#   --without-all           omit almost all features and build small executable
#                           with minimal dependencies
#   --without-pop           don't support POP mail retrieval with movemail
#   --with-kerberos         support Kerberos-authenticated POP
#   --with-kerberos5        support Kerberos version 5 authenticated POP
#   --with-hesiod           support Hesiod to get the POP server host
#   --with-mail-unlink      unlink, rather than empty, mail spool after reading
#   --with-mailhost=HOSTNAME
#                           string giving default POP mail host
#   --with-sound=VALUE      compile with sound support (VALUE one of: yes, alsa,
#                           oss, bsd-ossaudio, no; default yes). Only for
#                           GNU/Linux, FreeBSD, NetBSD, MinGW, Cygwin.
#   --with-x-toolkit=KIT    use an X toolkit (KIT one of: yes or gtk, gtk2,
#                           gtk3, lucid or athena, motif, no)
#   --with-wide-int         prefer wide Emacs integers (typically 62-bit);
#                           allows buffer and string size up to 2GB on 32-bit
#                           hosts, at the cost of 10% to 30% slowdown of Lisp
#                           interpreter and larger memory footprint
#   --without-xpm           don't compile with XPM image support
#   --without-jpeg          don't compile with JPEG image support
#   --without-tiff          don't compile with TIFF image support
#   --without-gif           don't compile with GIF image support
#   --without-png           don't compile with PNG image support
#   --without-rsvg          don't compile with SVG image support
#   --without-libsystemd    don't compile with libsystemd support
#   --with-cairo            compile with Cairo drawing (experimental)
#   --without-xml2          don't compile with XML parsing support
#   --without-imagemagick   don't compile with ImageMagick image support
#   --without-xft           don't use XFT for anti aliased fonts
#   --without-libotf        don't use libotf for OpenType font support
#   --without-m17n-flt      don't use m17n-flt for text shaping
#   --without-toolkit-scroll-bars
#                           don't use Motif or Xaw3d scroll bars
#   --without-xaw3d         don't use Xaw3d
#   --without-xim           don't use X11 XIM
#   --with-ns               use Nextstep (OS X Cocoa or GNUstep) windowing
#                           system. On by default on Mac OS X.
#   --with-w32              use native MS Windows GUI in a Cygwin build
#   --without-gpm           don't use -lgpm for mouse support on a GNU/Linux
#                           console
#   --without-dbus          don't compile with D-Bus support
#   --without-gconf         don't compile with GConf support
#   --without-gsettings     don't compile with GSettings support
#   --without-selinux       don't compile with SELinux support
#   --without-gnutls        don't use -lgnutls for SSL/TLS support
#   --without-zlib          don't compile with zlib decompression support
#   --with-modules          compile with dynamic modules support
#   --with-file-notification=LIB
#                           use a file notification library (LIB one of: yes,
#                           inotify, kqueue, gfile, w32, no)
#   --with-xwidgets         enable use of some gtk widgets in Emacs buffers
#                           (requires gtk3)
#   --without-makeinfo      don't require makeinfo for building manuals
#   --without-compress-install
#                           don't compress some files (.el, .info, etc.) when
#                           installing. Equivalent to: make GZIP_PROG= install
#   --with-gameuser=USER_OR_GROUP
#                           user for shared game score files. An argument
#                           prefixed by ':' specifies a group instead.
#   --with-gnustep-conf=FILENAME
#                           name of GNUstep configuration file to use on systems
#                           where the command 'gnustep-config' does not work;
#                           default $GNUSTEP_CONFIG_FILE, or
#                           /etc/GNUstep/GNUstep.conf
#   --with-x                use the X Window System
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
#   ALSA_CFLAGS C compiler flags for ALSA, overriding pkg-config
#   ALSA_LIBS   linker flags for ALSA, overriding pkg-config
#   XMKMF       Path to xmkmf, Makefile generator for X Window System
#   RSVG_CFLAGS C compiler flags for RSVG, overriding pkg-config
#   RSVG_LIBS   linker flags for RSVG, overriding pkg-config
#   IMAGEMAGICK_CFLAGS
#               C compiler flags for IMAGEMAGICK, overriding pkg-config
#   IMAGEMAGICK_LIBS
#               linker flags for IMAGEMAGICK, overriding pkg-config
#   GTK_CFLAGS  C compiler flags for GTK, overriding pkg-config
#   GTK_LIBS    linker flags for GTK, overriding pkg-config
#   WEBKIT_CFLAGS
#               C compiler flags for WEBKIT, overriding pkg-config
#   WEBKIT_LIBS linker flags for WEBKIT, overriding pkg-config
#   DBUS_CFLAGS C compiler flags for DBUS, overriding pkg-config
#   DBUS_LIBS   linker flags for DBUS, overriding pkg-config
#   GSETTINGS_CFLAGS
#               C compiler flags for GSETTINGS, overriding pkg-config
#   GSETTINGS_LIBS
#               linker flags for GSETTINGS, overriding pkg-config
#   GCONF_CFLAGS
#               C compiler flags for GCONF, overriding pkg-config
#   GCONF_LIBS  linker flags for GCONF, overriding pkg-config
#   GOBJECT_CFLAGS
#               C compiler flags for GOBJECT, overriding pkg-config
#   GOBJECT_LIBS
#               linker flags for GOBJECT, overriding pkg-config
#   LIBGNUTLS_CFLAGS
#               C compiler flags for LIBGNUTLS, overriding pkg-config
#   LIBGNUTLS_LIBS
#               linker flags for LIBGNUTLS, overriding pkg-config
#   LIBGNUTLS3_CFLAGS
#               C compiler flags for LIBGNUTLS3, overriding pkg-config
#   LIBGNUTLS3_LIBS
#               linker flags for LIBGNUTLS3, overriding pkg-config
#   LIBSYSTEMD_CFLAGS
#               C compiler flags for LIBSYSTEMD, overriding pkg-config
#   LIBSYSTEMD_LIBS
#               linker flags for LIBSYSTEMD, overriding pkg-config
#   KQUEUE_CFLAGS
#               C compiler flags for KQUEUE, overriding pkg-config
#   KQUEUE_LIBS linker flags for KQUEUE, overriding pkg-config
#   GFILENOTIFY_CFLAGS
#               C compiler flags for GFILENOTIFY, overriding pkg-config
#   GFILENOTIFY_LIBS
#               linker flags for GFILENOTIFY, overriding pkg-config
#   FONTCONFIG_CFLAGS
#               C compiler flags for FONTCONFIG, overriding pkg-config
#   FONTCONFIG_LIBS
#               linker flags for FONTCONFIG, overriding pkg-config
#   XFT_CFLAGS  C compiler flags for XFT, overriding pkg-config
#   XFT_LIBS    linker flags for XFT, overriding pkg-config
#   FREETYPE_CFLAGS
#               C compiler flags for FREETYPE, overriding pkg-config
#   FREETYPE_LIBS
#               linker flags for FREETYPE, overriding pkg-config
#   LIBOTF_CFLAGS
#               C compiler flags for LIBOTF, overriding pkg-config
#   LIBOTF_LIBS linker flags for LIBOTF, overriding pkg-config
#   M17N_FLT_CFLAGS
#               C compiler flags for M17N_FLT, overriding pkg-config
#   M17N_FLT_LIBS
#               linker flags for M17N_FLT, overriding pkg-config
#   CAIRO_CFLAGS
#               C compiler flags for CAIRO, overriding pkg-config
#   CAIRO_LIBS  linker flags for CAIRO, overriding pkg-config
#   XRANDR_CFLAGS
#               C compiler flags for XRANDR, overriding pkg-config
#   XRANDR_LIBS linker flags for XRANDR, overriding pkg-config
#   XINERAMA_CFLAGS
#               C compiler flags for XINERAMA, overriding pkg-config
#   XINERAMA_LIBS
#               linker flags for XINERAMA, overriding pkg-config
#   XFIXES_CFLAGS
#               C compiler flags for XFIXES, overriding pkg-config
#   XFIXES_LIBS linker flags for XFIXES, overriding pkg-config
#   LIBXML2_CFLAGS
#               C compiler flags for LIBXML2, overriding pkg-config
#   LIBXML2_LIBS
#               linker flags for LIBXML2, overriding pkg-config
#
# Use these variables to override the choices made by `configure' or to help
# it to find libraries and programs with nonstandard names/locations.
#
# Report bugs to <bug-gnu-emacs@gnu.org>.
# GNU Emacs home page: <http://www.gnu.org/software/emacs/>.
# General help using GNU software: <http://www.gnu.org/gethelp/>.

# }}}

# {{{ Prérequis

# sudo apt-get build-dep emacs

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

argument=$1

[[ $argument = boot ]] && {

	make clean

	make distclean

	make bootstrap-clean

	#make maintainer-clean

	#make extraclean
}

# }}}

# {{{ Préconfig

#./autogen.sh all

# }}}

# {{{ Configure

# Attention à ne pas mettre de commentaire
# entre deux lignes, sinon le shell croit
# qu'il s'agit de la commande suivante

./configure \
	--prefix=/usr/local

	# Fait planter le link lors de la compilation

	#--enable-link-time-optimization \

# }}}

# {{{ Make

if [[ $argument = boot ]]
then
	make bootstrap
else
	make
fi

# }}}

# {{{ Restauration

export CFLAGS=$sauve_cflags

export LDFLAGS=$sauve_ldflags

export PATH=$sauve_path

# }}}
