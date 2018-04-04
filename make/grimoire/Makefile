# vim: set ft=make :

include ../Makefile.inc

#  {{{  Phony

.PHONY: all install
.PHONY: clean clean-html clean-epub wipe

.PHONY: html
.PHONY: epub

#  }}}

# All, Install, Clean, Wipe {{{1

all: $(FICHIERS_HTML) $(FICHIERS_EPUB)

install: sync

clean:
	rm -f *~

clean-html:
	rm -f *.html
	rm -f *~

clean-epub:
	rm -f *.epub
	rm -f *~

wipe:
	rm -f *.html
	rm -f *.epub
	rm -f *~

# }}}1

#  {{{  Org -> Html

html: $(FICHIERS_HTML)

%.html: %.org $(FICHIERS_INCLUDE)
	$(EMACS) $(EMACS_PRE_FLAGS) $< $(EMACS_POST_FLAGS)
	@$(ECHO)

#  }}}

#  {{{  Org -> Epub

epub: $(FICHIERS_EPUB)

%.epub: %.org $(FICHIERS_INCLUDE)
	pandoc -t epub $< -o $(<:.org=.epub) 2> pandoc.log
	@$(ECHO)

#  }}}

# Sync -> html dir {{{1

dry-sync-html: html
	rsync -n -au --delete \
		--exclude-from=../rsync-html-exclude \
		-vhi --progress --stats $(REPERTOIRE_COURANT)/ $(REPERTOIRE_HTML)
	@$(ECHO)

sync-html: html
	rsync -au --delete \
		--exclude-from=../rsync-html-exclude \
		-vhi --progress --stats $(REPERTOIRE_COURANT)/ $(REPERTOIRE_HTML)
	@$(ECHO)

# }}}1

# Sync -> epub dir {{{1

dry-sync-epub: epub
	rsync -n -au --delete \
		--exclude-from=../rsync-epub-exclude \
		-vhi --progress --stats $(REPERTOIRE_COURANT)/ $(REPERTOIRE_EPUB)
	@$(ECHO)

sync-epub: epub
	rsync -au --delete \
		--exclude-from=../rsync-epub-exclude \
		-vhi --progress --stats $(REPERTOIRE_COURANT)/ $(REPERTOIRE_EPUB)
	@$(ECHO)

# }}}1

# {{{ Sync all

dry-sync: dry-sync-html dry-sync-epub

sync: sync-html sync-epub

# }}}
