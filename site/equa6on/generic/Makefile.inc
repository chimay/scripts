# vim: set ft=make :

#  {{{ root dir of generic, public

ROOT_GENERIC := $(HOME)/racine/site/equa6on/generic
ROOT_PUBLIC  := $(HOME)/racine/site/equa6on/public

#  }}}

#  {{{ local generic & public dir

CUR_DIR  = $(shell pwd)
PUBLIC_DIR = $(CUR_DIR:$(ROOT_GENERIC)%=$(ROOT_PUBLIC)%)

#  }}}

#  {{{ subdirs

SUBDIRS = $(wildcard */)

# phony subdirs for phony targets

DEBUG_SUBDIRS      = $(SUBDIRS:%=debug-%)

ORG_HTML_SUBDIRS   = $(SUBDIRS:%=org-html-%)
TEX_PDF_SUBDIRS    = $(SUBDIRS:%=tex-pdf-%)
TEX_HTML_SUBDIRS   = $(SUBDIRS:%=tex-html-%)

CLEAN_SUBDIRS      = $(SUBDIRS:%=clean-%)
CLEAN_HTML_SUBDIRS = $(SUBDIRS:%=clean-html-%)
WIPE_SUBDIRS       = $(SUBDIRS:%=wipe-%)

#  }}}

#  {{{ files

ORG_FILES     := $(wildcard *.org)
HTML_FILES    := ${ORG_FILES:.org=.html}
CSS_FILES     := $(wildcard $(ROOT_GENERIC)/style/*.css)
INC_FILES     := $(wildcard $(ROOT_GENERIC)/include/*.org)
ALL_TEX_FILES := $(wildcard *.tex)
TEX_FILES     := $(filter-out packages.tex commands.tex matemat.tex,$(ALL_TEX_FILES))
PDF_FILES     := ${TEX_FILES:.tex=.pdf}

HTML_FOLDERS   := ${TEX_FILES:%.tex=../html/%}

#  }}}

#  {{{ programs & options

ECHO  = echo

EMACS            = /usr/bin/emacs
EMACS_PRE_FLAGS  = --batch --file
EMACS_POST_FLAGS = -f org-html-export-to-html --kill 2> emacs.log

#--script=$(ROOT_GENERIC)/script.el

DRY_RSYNC = rsync -n -au --delete --exclude-from=./rsync-public-exclude -vhi --progress
RSYNC     = rsync -au --delete --exclude-from=./rsync-public-exclude -vhi --progress

#  }}}
