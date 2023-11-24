# vim: set ft=make :

# root dir of generic, html, epub {{{1

ROOT_GENERIC := $(HOME)/racine/site/eclats2vers/generic
ROOT_HTML    := $(HOME)/racine/site/eclats2vers/html
ROOT_EPUB    := $(HOME)/racine/site/eclats2vers/epub

# local generic & html dir {{{1

CUR_DIR  = $(shell pwd)
HTML_DIR = $(CUR_DIR:$(ROOT_GENERIC)%=$(ROOT_HTML)%)
EPUB_DIR = $(CUR_DIR:$(ROOT_GENERIC)%=$(ROOT_EPUB)%)

# subdirs {{{1

SUBDIRS            = $(wildcard */)
HTML_SUBDIRS       = $(SUBDIRS:%=html-%)
EPUB_SUBDIRS       = $(SUBDIRS:%=epub-%)
CLEAN_SUBDIRS      = $(SUBDIRS:%=clean-%)
CLEAN_HTML_SUBDIRS = $(SUBDIRS:%=clean-html-%)
CLEAN_EPUB_SUBDIRS = $(SUBDIRS:%=clean-epub-%)
WIPE_SUBDIRS       = $(SUBDIRS:%=wipe-%)

# files {{{1

ORG_FILES = $(wildcard *.org)
HTML_FILES = $(ORG_FILES:.org=.html)
EPUB_FILES = $(ORG_FILES:.org=.epub)
CSS_FILES  = $(wildcard $(ROOT_GENERIC)/style/*.css)
INC_FILES  = $(wildcard $(ROOT_GENERIC)/include/*.org)

# HTML_FILES = $(patsubst %.org,%.html,$(wildcard *.org))
# EPUB_FILES = $(patsubst %.org,%.epub,$(wildcard *.org))

# files in ~/racine/musica/lilypond/template

LY_MEL_FILES = $(wildcard ~/racine/musica/lilypond/template/include/mel*.ly)

# programs & options {{{1

ECHO  = echo

EMACS            = /usr/bin/emacs
EMACS_PRE_FLAGS  =
EMACS_POST_FLAGS = --batch -f org-html-export-to-html --kill 2> emacs.log

DRY_RSYNC = rsync -n -au --delete --exclude-from=./rsync-html-exclude -vhi --progress
RSYNC     = rsync -au --delete --exclude-from=./rsync-html-exclude -vhi --progress
