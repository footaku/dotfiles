#!/bin/bash

f() {
  git ch stash@{${1}} ${2}; \
  git unstage ${2}
}

if [[ $# -eq 2 ]]; then
  f ${1} ${2}
fi
exit 0
