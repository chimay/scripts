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

debug:
	@echo $(ALL_TEX_FILES)

# }}}1

#  {{{  org -> html

org-html:

#  }}}

# tex -> pdf {{{1

tex-pdf:

# }}}1

# tex -> html {{{1

tex-html:

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
