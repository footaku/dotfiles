#!/bin/bash

### Mac startup sound disable
sudo nvram SystemAudioVolume=%80

### Mac dock icons remove all
defaults write com.apple.dock persistent-apps -array
killall Dock

### install homebrew
sudo xcodebuild -license
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo 'export HOMEBREW_CASK_OPTS="--appdir=/Applications"' >> ~/.bash_profile
source ~/.bash_profile

### install ansible
brew update
brew install python
brew install ansible
mkdir -p ansible && cd $_
echo 'localhost' > hosts

### create playbook
cat << EOS > local-assemble.yml
- hosts: localhost
  connection: local
  gather_facts: no
  sudo: no

  tasks:
    - name: Install homebrew packages
      homebrew: name={{ item }}
      with_items:
        - git
        - jq
        - openssl
        - ansible
        - colordiff
        - wget
        - curl
        - nkf
        - bash-completion
    - name: Add homebrew tap repositories
      homebrew_tap: tap={{ item }} state=present
      with_items:
        - caskroom/cask
    - name: Install Homebrew cask packages
      homebrew_cask: name={{ item }}
      with_items:
        - iterm2
        - google-chrome
        - google-japanese-ime
        - alfred
        - slack
        - atom
        - intellij-idea
        - virtualbox
        - clipy
        - sequel-pro
        - chatwork
        - 1password
        - dropbox
EOS

### execute ansible
ansible-playbook -i hosts -vvv local-assemble.yml

### use newly openssl
brew link openssl --force
echo "export PATH=/usr/local/opt/openssl/bin:$PATH" >> ~/.bash_profile
echo "export LD_LIBRARY_PATH=/usr/local/opt/openssl/lib:$LD_LIBRARY_PATH" >> ~/.bash_profile
echo "export CPATH=/usr/local/opt/openssl/include:$LD_LIBRARY_PATH" >> ~/.bash_profile
source ~/.bash_profile

exit 0
