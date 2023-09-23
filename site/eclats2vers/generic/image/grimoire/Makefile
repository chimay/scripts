# vim: set ft=make :

include ../../Makefile.inc

.DEFAULT_GOAL := sync-html

#  {{{  phony

.PHONY: debug

.PHONY: html
.PHONY: epub

.PHONY: all install
.PHONY: clean clean-html clean-epub wipe

#  }}}

# debug {{{1

debug:
	@echo $(SUBDIRS)

# }}}1

#  {{{  org -> html

html:
	$(ECHO) nothing to do
	@$(ECHO)

#  }}}

#  {{{  org -> epub

epub:
	$(ECHO) nothing to do
	@$(ECHO)

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
	$(RSYNC) $(CUR_DIR)/ $(EPUB_DIR)
	@$(ECHO)

# }}}1

# {{{ sync all

dry-sync: dry-sync-html dry-sync-epub

sync: sync-html sync-epub

# }}}

# all, install, clean, wipe {{{1

all: sync-html

install: sync-html

clean:
	rm -f ?*~

clean-html:
	rm -f ?*.html
	rm -f ?*~

clean-epub:
	rm -f ?*.epub
	rm -f ?*~

wipe:
	rm -f ?*.html
	rm -f ?*.epub
	rm -f ?*~

# }}}1
