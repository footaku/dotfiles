#!/bin/sh

printf '\n\033[1;36m### update \033[m\n' && \
  brew update && \
  printf '\n\033[1;36m### upgrade \033[m\n' && \
  brew upgrade && \
  printf '\n\033[1;36m### prune \033[m\n' && \
  brew prune && \
  printf '\n\033[1;36m### cleanup \033[m\n' && \
  brew cleanup && \
  printf '\n\033[1;36m### doctor \033[m\n' && \
  brew doctor

exit 0
