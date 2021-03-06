#!/usr/bin/env -S sed -f

# vim:filetype=sed:nofoldenable:

# Include
# ------------------------------

s/^#+include: "\([^"]\+\)"$/org2vimwiki.sed \1/e
s/^#+INCLUDE: "\([^"]\+\)"$/org2vimwiki.sed \1/e

# Italic
# ------------------------------

\: / :b skip-italic
\://:b skip-italic
/\[\[.*\]\]/b skip-italic
\:\S/\S:b skip-italic

s:/\([^]/[]\+\)/:_\1_:g

: skip-italic

# Verbatim
# ------------------------------

s:=//=://:g
s/=\.\.\.\+=/.../g

/\[\[.*\]\]/b skip-verbatim
/\S=\S/b skip-verbatim

s/=\([^]=[ \t]\+\)=/`\1`/g

: skip-verbatim

# Code
# ------------------------------

s/~\([^~]\+\)~/`\1`/g

# Tables
# ------------------------------

s/\([|+]-*-\)+/\1|/g
s/+\(-*-[|+]\)/|\1/g

# Code blocs
# ------------------------------

s/^#+begin_src emacs-lisp$/{{{lisp/
s/^#+BEGIN_SRC emacs-lisp$/{{{lisp/

s/^#+begin_src \(.*\)$/{{{\1/
s/^#+BEGIN_SRC \(.*\)$/{{{\1/

s/^#+end_src$/}}}/
s/^#+END_SRC$/}}}/

# Pre formatted text
# ------------------------------

s/^#+begin_verse/{{{/
s/^#+BEGIN_VERSE/{{{/

s/^#+end_verse/}}}/
s/^#+END_VERSE/}}}/

# Links
# ------------------------------

s/\[\[\([^]]*\)\]\[\([^]]*\)\]\]/[[\1|\2]]/g
s/\(\[\[[^*]*\)\*\([^*]*\]\]\)/\1#\2/g
s/\(\[\[[^*]*\)file:\([^*]*\]\]\)/\1\2/g
s/\(\[\[[^*]*\)\.org\([^*]*\]\]\)/\1\2/g

# Headers
# ------------------------------

# Tags

s/^\*\*\*\*\*\* \([^:]*\)\(:.*:\)$/====== \1 ======\n\2/
s/^\*\*\*\*\* \([^:]*\)\(:.*:\)$/===== \1 =====\n\2/
s/^\*\*\*\* \([^:]*\)\(:.*:\)$/==== \1 ====\n\2/
s/^\*\*\* \([^:]*\)\(:.*:\)$/=== \1 ===\n\2/
s/^\*\* \([^:]*\)\(:.*:\)$/== \1 ==\n\2/
s/^\* \([^:]*\)\(:.*:\)$/= \1 =\n\2/

# Without tags

s/^\*\*\*\*\*\* \(.*\)$/====== \1 ======/
s/^\*\*\*\*\* \(.*\)$/===== \1 =====/
s/^\*\*\*\* \(.*\)$/==== \1 ====/
s/^\*\*\* \(.*\)$/=== \1 ===/
s/^\*\* \(.*\)$/== \1 ==/
s/^\* \(.*\)$/= \1 =/

# Multiple spaces

/^=.*=$/! s/  \+/ /g

# Table of contents
# ------------------------------

# Local toc not supported

/^#+toc: .*local/d
/^#+TOC: .*local/d

# Global toc

s/^#+toc: .*$/= Contents =/
s/^#+TOC: .*$/= Contents =/

# Title
# ------------------------------

s/^#+title: \(.*\)$/%title \1/
s/^#+TITLE: \(.*\)$/%title \1/

# Delete emacs -*- lines
# ------------------------------

/-\*-.*mode: org.*-\*-/d

# Replace other #+ directives by %% comments
# ---------------------------------------------

s/^#+.*$/%% &/
t skip-comment

# Replace other # comments by %% comments
# ---------------------------------------------

s/^#\(.*\)$/%% \1/

: skip-comment
