#!/bin/bash

GOOGLE_DIFFS=../patches

PATCHED_PROJECTS=$(
  for i in ${GOOGLE_DIFFS}
  do
    (
      cd $i
      find . -type d -print
    )
  done | sort -u |
    while read _dir
    do
      if [ -d .$_dir/.git ]; then
        echo .$_dir
      fi
    done
)

repo forall $PATCHED_PROJECTS -c git checkout -f
repo forall $PATCHED_PROJECTS -c git clean -d -f -x

echo
echo Repo status for $PATCHED_PROJECTS
repo status $PATCHED_PROJECTS