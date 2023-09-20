#! /usr/bin/env sh

du -sh .git
echo
git repack
git prune-packed
git reflog expire --expire=1.month.ago
git gc --aggressive
echo
du -sh .git
