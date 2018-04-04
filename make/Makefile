# vim: set ft=make :

include Makefile.inc

#  {{{  Phony

.PHONY: all install
.PHONY: clean clean-html clean-epub wipe

.PHONY: html
.PHONY: epub

.PHONY: dry-sync-html sync-html
.PHONY: dry-sync-epub sync-epub
.PHONY: dry-sync sync

.PHONY: $(SUBDIRS)
.PHONY: $(INSTALL_SUBDIRS)
.PHONY: $(CLEAN_SUBDIRS) $(CLEAN_HTML_SUBDIRS) $(CLEAN_EPUB_SUBDIRS) $(WIPE_SUBDIRS)
.PHONY: $(HTML_SUBDIRS) $(EPUB_SUBDIRS)

#  }}}

# All, Install, Clean, Wipe {{{1

all: $(SUBDIRS) $(FICHIERS_HTML) $(FICHIERS_EPUB)

install: sync

clean: $(CLEAN_SUBDIRS)
	rm -f *~

clean-html: $(CLEAN_HTML_SUBDIRS)
	rm -f *.html
	rm -f *~

clean-epub: $(CLEAN_EPUB_SUBDIRS)
	rm -f *.epub
	rm -f *~

wipe: $(WIPE_SUBDIRS)
	rm -f *.html
	rm -f *.epub
	rm -f *~

# }}}1

#  {{{  Org -> Html

html: $(HTML_SUBDIRS) $(FICHIERS_HTML)

%.html: %.org $(FICHIERS_INCLUDE)
	$(EMACS) $(EMACS_PRE_FLAGS) $< $(EMACS_POST_FLAGS)
	@$(ECHO)

#  }}}

#  {{{  Org -> Epub

epub: $(EPUB_SUBDIRS) $(FICHIERS_EPUB)

%.epub: %.org $(FICHIERS_INCLUDE)
	pandoc -t epub $< -o $(<:.org=.epub) 2> pandoc.log
	@$(ECHO)

#  }}}

# Sync -> html dir {{{1

dry-sync-html: html
	rsync -n -au --delete \
		--exclude-from=rsync-html-exclude \
		-vhi --progress --stats $(RACINE_ORGMODE)/ $(RACINE_HTML)
	@$(ECHO)

sync-html: html
	rsync -au --delete \
		--exclude-from=rsync-html-exclude \
		-vhi --progress --stats $(RACINE_ORGMODE)/ $(RACINE_HTML)
	@$(ECHO)

# }}}1

# Sync -> epub dir {{{1

dry-sync-epub: epub
	rsync -n -au --delete \
		--exclude-from=rsync-epub-exclude \
		-vhi --progress --stats $(RACINE_ORGMODE)/ $(RACINE_EPUB)
	@$(ECHO)

sync-epub: epub
	rsync -au --delete \
		--exclude-from=rsync-epub-exclude \
		-vhi --progress --stats $(RACINE_ORGMODE)/ $(RACINE_EPUB)
	@$(ECHO)

# }}}1

# {{{ Sync all

dry-sync: dry-sync-html dry-sync-epub

sync: sync-html sync-epub

# }}}

#  {{{  Subdirs

$(SUBDIRS):
	$(MAKE) -C $@
	@$(ECHO)

$(INSTALL_SUBDIRS):
	$(MAKE) -C ${@:install-%=%} install
	@$(ECHO)

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

$(HTML_SUBDIRS):
	$(MAKE) -C ${@:html-%=%} html
	@$(ECHO)

$(EPUB_SUBDIRS):
	$(MAKE) -C ${@:epub-%=%} epub
	@$(ECHO)

#  }}}
