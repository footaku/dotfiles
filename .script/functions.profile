# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fh - repeat history
fh() {
  local hst=$(history | fzf | awk '{OFS=" ";$1="";print $0}' | sed -e "s/^ //")
  if [[ -z ${hst} ]]; then
    return
  fi
  printf "execute '${hst}'\n"
  ${hst}
}

# sp - network profile change (for Mac)
sp() {
  local location=$(networksetup -listlocations | fzf)
  if [[ -z ${location} ]]; then
    return
  fi
  sudo networksetup -switchtolocation ${location}
}

# ffh - ssh from .ssh/config
ffh() {
  local host=$(cat ~/.ssh/config | grep "Host " | grep -Ev "[#\*]" | sort | awk '{print $2}' | fzf)
  if [[ -z ${host} ]]; then
    return
  fi
  ssh ${host}
}
