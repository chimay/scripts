#!/usr/bin/env -S sed -f

# vim:filetype=sed:nofoldenable:

# Include

s/^#+include: "\([^"]\+\)"$/org2vimwiki.sed \1/e

s/^#+INCLUDE: "\([^"]\+\)"$/org2vimwiki.sed \1/e

# Italic

s:/^[^[]]*\([^/]\+\)/[^[]]*$:_\1_:g

# Code

s/~\([^~]\+\)~/`\1`/g

# Verbatim

s/=\([^=]\+\)=/`\1`/g

# Tables

s/\([|+]-*-\)+/\1|/g
s/+\(-*-[|+]\)/|\1/g

# Code blocs

s/^#+begin_src emacs-lisp$/{{{lisp/
s/^#+begin_src \(.*\)$/{{{\1/

s/^#+BEGIN_SRC emacs-lisp$/{{{lisp/
s/^#+BEGIN_SRC \(.*\)$/{{{\1/

# Links

s/\[\[\([^]]*\)\]\[\([^]]*\)\]\]/[[\1|\2]]/g
s/\(\[\[[^*]*\)\*\([^*]*\]\]\)/\1#\2/g
s/\(\[\[[^*]*\)file:\([^*]*\]\]\)/\1\2/g
s/\(\[\[[^*]*\)\.org\([^*]*\]\]\)/\1\2/g

# Headers

s/^\*\*\*\*\*\* \(.*\)$/====== \1 ======/
s/^\*\*\*\*\* \(.*\)$/===== \1 =====/
s/^\*\*\*\* \(.*\)$/==== \1 ====/
s/^\*\*\* \(.*\)$/=== \1 ===/
s/^\*\* \(.*\)$/== \1 ==/
s/^\* \(.*\)$/= \1 =/

# Table of contents

s/^#+toc: .*$/= Contents =/

s/^#+TOC: .*$/= Contents =/

# Title

s/^#+title: \(.*\)$/%title \1/

s/^#+TITLE: \(.*\)$/%title \1/

# Delete emacs -*- lines

/-\*-.*mode: org.*-\*-/d

# Replace other #+ directives by %% comments

s/^#+.\+:.*$/%% &/

# Replace other # comments by %% comments

s/^#\(.*\)$/%% \1/
