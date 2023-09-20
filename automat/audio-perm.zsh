#! /usr/bin/env zsh

dossier=${1:-~/audio}

cd $dossier

# echo chmod u+rwx **/*(/) | sed -e 's/\s\+/\n/g' | less
# echo chmod go+rx **/*(/) | sed -e 's/\s\+/\n/g' | less
# echo chmod go-w **/*(/) | sed -e 's/\s\+/\n/g' | less
# echo
# echo chmod u+rw **/*(.) | sed -e 's/\s\+/\n/g' | less
# echo chmod u-x **/*(.) | sed -e 's/\s\+/\n/g' | less
# echo
# echo chmod go+r **/*(.) | sed -e 's/\s\+/\n/g' | less
# echo chmod go-wx **/*(.) | sed -e 's/\s\+/\n/g' | less

# ----

chmod u+rwx **/*(/)
chmod go+rx **/*(/)
chmod go-w **/*(/)

chmod u+rw **/*(.)
chmod u-x **/*(.)

chmod go+r **/*(.)
chmod go-wx **/*(.)
