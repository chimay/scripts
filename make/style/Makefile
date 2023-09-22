# vim: set ft=make :

include ../Makefile.inc

.DEFAULT_GOAL := sync-html

#  {{{  phony

.PHONY: debug

.PHONY: html
.PHONY: epub

.PHONY: dry-sync-html sync-html
.PHONY: dry-sync-epub sync-epub
.PHONY: dry-sync sync

.PHONY: all install

.PHONY: $(HTML_SUBDIRS) $(EPUB_SUBDIRS)
.PHONY: $(CLEAN_SUBDIRS) $(CLEAN_HTML_SUBDIRS) $(CLEAN_EPUB_SUBDIRS) $(WIPE_SUBDIRS)

.PHONY: clean clean-html clean-epub wipe

#  }}}

# debug {{{1

debug:
	@echo $(SUBDIRS)

# }}}1

#  {{{  org -> html

html:
	@$(ECHO) nothing to do

#  }}}

#  {{{  org -> epub

epub:
	@$(ECHO) nothing to do

#  }}}

# sync -> html dir {{{1

dry-sync-html: html
	$(DRY_RSYNC) $(CUR_DIR)/ $(HTML_DIR)
	@$(ECHO)

sync-html: html
	$(RSYNC) $(CUR_DIR)/ $(HTML_DIR)
	@$(ECHO)

# }}}1

# sync -> epub dir {{{1

dry-sync-epub: epub
	$(DRY_RSYNC) $(CUR_DIR)/ $(EPUB_DIR)
	@$(ECHO)

sync-epub: epub
	$(SYNC) $(CUR_DIR)/ $(EPUB_DIR)
	@$(ECHO)

# }}}1

# {{{ sync all

dry-sync: dry-sync-html dry-sync-epub

sync: sync-html sync-epub

# }}}

# all, install {{{1

all: sync-html

install: sync-html

# }}}1

# clean, wipe {{{1

$(CLEAN_SUBDIRS):
	$(MAKE) -C ${@:clean-%=%} clean
	@$(ECHO)

$(CLEAN_HTML_SUBDIRS):
	$(MAKE) -C ${@:clean-html-%=%} clean-html
	@$(ECHO)

$(CLEAN_EPUB_SUBDIRS):
	$(MAKE) -C ${@:clean-epub-%=%} clean-epub
	@$(ECHO)

$(WIPE_SUBDIRS):
	$(MAKE) -C ${@:wipe-%=%} wipe
	@$(ECHO)

clean: $(CLEAN_SUBDIRS)
	rm -f ?*~

clean-html: $(CLEAN_HTML_SUBDIRS)
	rm -f ?*.html
	rm -f ?*~

clean-epub: $(CLEAN_EPUB_SUBDIRS)
	rm -f ?*.epub
	rm -f ?*~

wipe: $(WIPE_SUBDIRS)
	rm -f ?*.html
	rm -f ?*.epub
	rm -f ?*~

# }}}1
