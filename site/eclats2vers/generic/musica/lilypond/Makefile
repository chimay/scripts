# vim: set ft=make :

include ../../Makefile.inc

.DEFAULT_GOAL := sync-html

#  phony {{{1

.PHONY: html sync-html

# html {{{1

html: sync-html

# sync -> html dir {{{1

dry-sync-html: $(LY_TMPL_FILES) $(LY_MLD_FILES) $(LY_GLOB_FILES)
	$(DRY_RSYNC) $(CUR_DIR)/ $(HTML_DIR)
	@$(ECHO)

sync-html: $(LY_TMPL_FILES) $(LY_MLD_FILES) $(LY_GLOB_FILES)
	$(RSYNC) $(CUR_DIR)/ $(HTML_DIR)
	@$(ECHO)
