# vim: set ft=make :

include ../Makefile.inc

.DEFAULT_GOAL := all

#  {{{  phony

.PHONY: debug

.PHONY: org-html tex-pdf tex-html

.PHONY: dry-sync sync

.PHONY: all install

.PHONY: $(ORG_HTML_SUBDIRS) $(TEX_PDF_SUBDIRS) $(TEX_HTML_SUBDIRS)
.PHONY: $(CLEAN_SUBDIRS) $(CLEAN_HTML_SUBDIRS) $(WIPE_SUBDIRS)

.PHONY: clean clean-html wipe

#  }}}

# debug {{{1

$(DEBUG_SUBDIRS):
	$(MAKE) -C ${@:debug-%=%} debug
	@$(ECHO)

debug: $(DEBUG_SUBDIRS)
	@echo $(ALL_TEX_FILES)

# }}}1

#  {{{  org -> html

$(ORG_HTML_SUBDIRS):
	$(MAKE) -C ${@:org-html-%=%} org-html
	@$(ECHO)

%.html: %.org $(INC_FILES)
	$(EMACS) $(EMACS_PRE_FLAGS) $< $(EMACS_POST_FLAGS)
	remove-max-width-from-org-html-export.zsh ${<:.org=.html}
	@$(ECHO)

org-html: $(ORG_HTML_SUBDIRS) $(HTML_FILES)

#  }}}

# tex -> pdf {{{1

$(TEX_PDF_SUBDIRS):
	$(MAKE) -C ${@:tex-pdf-%=%} tex-pdf
	@$(ECHO)

matemat.pdf : matemat.tex $(TEX_FILES)
	latexmk -f -pdf $<

%.pdf : %.tex
	latexmk -f -pdf $<

tex-pdf: $(TEX_PDF_SUBDIRS) $(PDF_FILES)

# }}}1

# tex -> html {{{1

$(TEX_HTML_SUBDIRS):
	$(MAKE) -C ${@:tex-html-%=%} tex-html
	@$(ECHO)

../html/%: %.tex
	latex2html -mkdir -dir ../html/$* -split 0 $<
	rm -f ../html/$*/*.old

tex-html: $(TEX_HTML_SUBDIRS) $(HTML_FOLDERS)

# }}}1

# sync {{{1

dry-sync: org-html tex-pdf tex-html
	$(DRY_RSYNC) $(CUR_DIR)/ $(PUBLIC_DIR)
	@$(ECHO)

sync: org-html tex-pdf tex-html
	$(RSYNC) $(CUR_DIR)/ $(PUBLIC_DIR)
	@$(ECHO)

# }}}1

# all, install {{{1

all: org-html tex-pdf tex-html sync

install: sync

# }}}1

# clean, wipe {{{1

$(CLEAN_SUBDIRS):
	$(MAKE) -C ${@:clean-%=%} clean
	@$(ECHO)

$(CLEAN_HTML_SUBDIRS):
	$(MAKE) -C ${@:clean-html-%=%} clean-html
	@$(ECHO)

$(WIPE_SUBDIRS):
	$(MAKE) -C ${@:wipe-%=%} wipe
	@$(ECHO)

clean: $(CLEAN_SUBDIRS)
	rm -f ?*~ ?*.log ?*.aux ?*.out ?*.toc ?*.dvi ?*.fls ?*.fdb_latexmk

clean-html: $(CLEAN_HTML_SUBDIRS)
	rm -f ?*~ ?*.html

wipe: clean $(WIPE_SUBDIRS)
	rm -f ?*~ ?*.html ?*.pdf

# }}}1
