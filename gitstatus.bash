#!/bin/bash

f() {
  echo -e '\n\e[1;36m### status ################# \e[m'; \
  git status; \
  echo -e '\n\e[1;36m### branch ################# \e[m'; \
  git branch -vv; \
  echo -e '\n\e[1;36m### stash ################# \e[m'; \
  git stash list; \
  echo -e '\n\e[1;36m### log ################# \e[m'; \
  git lo -10; \
  echo -e '\n' | cat
}
f
exit 0

