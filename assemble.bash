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
  become: no

  vars:
    homebrew_taps:
      - caskroom/cask
    homebrews:
      - { name: git }
      - { name: jq }
      - { name: openssl }
      - { name: openssl, state: linked, install_options: force }
      - { name: ansible }
      - { name: colordiff }
      - { name: wget }
      - { name: curl }
      - { name: nkf }
      - { name: bash-completion }
      - { name: wireshark, install_options: with-qt5 }
      - { name: hadolint }
      - { name: mysql, install_options: client-only}
      - { name: pygtk }
    homebrew_casks:
      - { name: java }
      - { name: iterm2 }
      - { name: google-chrome }
      - { name: google-japanese-ime }
      - { name: alfred }
      - { name: slack }
      - { name: atom }
      - { name: intellij-idea }
      - { name: datagrip }
      - { name: virtualbox }
      - { name: clipy }
      - { name: chatwork }
      - { name: 1password }
      - { name: dropbox }
      - { name: caffeine }
      - { name: keyboardcleantool }
      - { name: hyperswitch }
      - { name: skitch }
      - { name: meld }

  tasks:
    - name: homebrew の tap リポジトリを追加
      homebrew_tap: tap={{ item }} state=present
      with_items: "{{ homebrew_taps }}"

    - name: homebrew をアップデート
      homebrew: update_homebrew=yes upgrade_all=yes

    - name: brew パッケージをインストール
      homebrew: >
        name={{ item.name }}
        state={{ item.state | default('latest') }}
        install_options={{
          item.install_options | default() | join(',')
          if item.install_options is not string
          else item.install_options
        }}
      with_items: "{{ homebrews }}"

    - name: brew cask パッケージをインストール
      homebrew_cask: name={{ item.name }} state={{ item.state|default('installed') }}
      with_items: "{{ homebrew_casks }}"
EOS

### execute ansible
ansible-playbook -i hosts -vvv local-assemble.yml

### use newly openssl
brew link openssl --force
echo "export PATH=/usr/local/opt/openssl/bin:$PATH" >> ~/.bash_profile
echo "export LD_LIBRARY_PATH=/usr/local/opt/openssl/lib:$LD_LIBRARY_PATH" >> ~/.bash_profile
echo "export CPATH=/usr/local/opt/openssl/include:$LD_LIBRARY_PATH" >> ~/.bash_profile
echo "export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH" >> ~/.bash_profile
echo "export PS1='\[\e[1;32m\]\h:\W \u\$\[\e[00m\] '" >> ~/.bash_profile
source ~/.bash_profile

exit 0
