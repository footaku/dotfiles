if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_144`

alias ll='ls -laG'
alias dk='docker'
alias dkb='docker build -t '
alias dke='docker exec'
alias dkc='docker ps -a -q | xargs -n 1 docker rm'
alias dkci='docker images | grep -E "^<none>" | awk '\''{ print $3 }'\'' | xargs -n 1 docker rmi'
alias dkrm='docker rm'
alias dkstop='docker stop'
alias jxa="osascript -l JavaScript"

export PATH=/usr/local/opt/openssl/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/opt/openssl/lib:$LD_LIBRARY_PATH
export CPATH=/usr/local/opt/openssl/include:$LD_LIBRARY_PATH
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
export GRAPHVIZ_DOT=/usr/local/bin/dot

export PS1='\[\e[1;32m\]\h:\W \u\$\[\e[00m\] '
# Add Visual Studio Code (code)
export PATH="/usr/local/opt/openssl/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

source ~/.script/functions.profile
