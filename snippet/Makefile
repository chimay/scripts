# vim: set ft=make :

SHELL=/bin/bash

TREE_LS = $(shell ls **/*)
TREE_C = $(shell zsh -c 'print **/*')

tree:
	@echo $(TREE_LS)
	@echo
	@echo $(TREE_C)
	@echo

ZSH_FILES := $(shell find . -maxdepth 2 -type f -regex '.*\.zsh')
FIND   := $(filter-out ./,$(dir $(ZSH_FILES)))

find:
	echo $(ZSH_FILES})
	echo $(FIND)


LS := $(shell ls -d */)

ls:
	echo $(LS)

rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

RWILD := $(call rwildcard,./,*.zsh)

rwild:
	echo $(RWILD)

# --

subdirs    := $(wildcard */)
sources    := $(wildcard $(addsuffix *.zsh,$(subdirs)))
patsub     := $(patsubst %.zsh,%.coucou,$(sources))
snip_files := $(wildcard *.snip)
ps         := $(snip_files:%.snip=%.replaced)

patsub:
	@echo $(patsub)
	@echo $(ps)


recurfind = $(shell find $(1) -name '$(2)')
SRCS := $(call recurfind,.,*.zsh) $(call recurfind,.,*.snip)

recurfind:
	echo $(SRCS)

SNIP_FILES = hist/archlinux.snip hist/freebsd.snip hist/linuxmint.snip

$(filter %.snip,$(SNIP_FILES)): %.snip: %.zsh
	@echo "target: $@ prereq: $<"
