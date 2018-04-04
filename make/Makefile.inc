# vim: set ft=make :

#  {{{ Racine Org, Html, Epub

RACINE_ORGMODE = $(HOME)/racine/site/orgmode

RACINE_HTML = $(HOME)/racine/site/html

RACINE_EPUB = $(HOME)/racine/site/epub

#  }}}

#  {{{ Programmes & Options

ECHO = echo
EMACS = /usr/local/bin/emacs
MAKE = /usr/bin/make

EMACS_PRE_FLAGS = --batch --file
EMACS_POST_FLAGS = -f org-html-export-to-html --kill 2> emacs.log

#  }}}

#  {{{ Local Org & Html

REPERTOIRE_COURANT = $(shell pwd)

REPERTOIRE_HTML = $(REPERTOIRE_COURANT:$(RACINE_ORGMODE)%=$(RACINE_HTML)%)

REPERTOIRE_EPUB = $(REPERTOIRE_COURANT:$(RACINE_ORGMODE)%=$(RACINE_EPUB)%)

#  }}}

#  {{{ Fichiers

FICHIERS_HTML = $(patsubst %.org,%.html,$(wildcard *.org))

FICHIERS_CSS = $(HTML)/style/defaut.css

FICHIERS_INCLUDE = $(wildcard $($(RACINE_ORGMODE)/include/*))

FICHIERS_EPUB = $(patsubst %.org,%.epub,$(wildcard *.org))

#  }}}

# {{{ Fichiers installés

FICHIERS_INSTALLES_HTML = $(patsubst %.org,$(REPERTOIRE_HTML)/%.html,$(wildcard *.org))

FICHIERS_INSTALLES_CSS = $(patsubst %.org,$(REPERTOIRE_HTML)/%.html,$(wildcard *.org))

FICHIERS_INSTALLES_EPUB = $(patsubst %.org,$(REPERTOIRE_HTML)/%.epub,$(wildcard *.html))

# }}}

#  {{{ Sous-répertoires

SUBDIRS = grimoire litera musica

INSTALL_SUBDIRS = $(SUBDIRS:%=install-%)

CLEAN_SUBDIRS = $(SUBDIRS:%=clean-%)

CLEAN_HTML_SUBDIRS = $(SUBDIRS:%=clean-html-%)

CLEAN_EPUB_SUBDIRS = $(SUBDIRS:%=clean-epub-%)

WIPE_SUBDIRS = $(SUBDIRS:%=wipe-%)

HTML_SUBDIRS = $(SUBDIRS:%=html-%)

EPUB_SUBDIRS = $(SUBDIRS:%=epub-%)

#  }}}
