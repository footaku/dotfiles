#!/bin/bash

f() {
  printf '\n\033[1;36m### status ################# \033[m\n'; \
  git status; \
  printf '\n\033[1;36m### branch ################# \033[m\n'; \
  git branch -vv; \
  printf '\n\033[1;36m### stash ################# \033[m\n'; \
  git stash list; \
  printf '\n\033[1;36m### log ################# \033[m\n'; \
  git lo -10; \
  printf '\n' | cat
}
f
exit 0
