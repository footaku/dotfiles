if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_102`

alias ll='ls -laG'
alias dk='docker'
alias dk-b='docker build -t '
alias dk-e='docker exec'
alias dk-c='docker ps -a -q | xargs -n 1 docker rm'
alias dk-ci='docker images | grep -E "^<none>" | awk '\''{ print $3 }'\'' | xargs -n 1 docker rmi'
alias dkrm='docker rm'
alias dkstop='docker stop'

export PATH=/usr/local/opt/openssl/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/opt/openssl/lib:$LD_LIBRARY_PATH
export CPATH=/usr/local/opt/openssl/include:$LD_LIBRARY_PATH
