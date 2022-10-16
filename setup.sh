#!/bin/bash

echo '\nSetting up my dev environment\n'
source /etc/os-release
if [[ $OSTYPE == 'darwin'* ]]; then
    echo '\nMacOS detected\n'
    which -s brew
    if [[ $? != 0 ]] ; then
        echo '\nInstalling Homebrew\n'
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo '\nUpdating Homebrew\n'
        brew update
    fi
    echo '\nUpdating packages\n'
    brew upgrade
    echo '\nInstalling packages\n'
    brew install neovim kitty fd ripgrep fzy font-iosevka stow
elif [[ $PRETTY_NAME == 'Fedora'* ]]; then
    echo '\nUpdating packages\n'
    sudo dnf upgrade --refresh
    echo '\nInstalling packages\n'
    sudo dnf install neovim kitty fd-find git
else
    echo '\nDid not identify OS as MacOS or Fedora. Exiting\n'
    exit 1
fi

echo '\nInstalling latest nvm version\n'
export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
)

echo '/nConfiguring Git'
git config --global pull.rebase false
git config --global push.default current
git config --global core.excludesfile $HOME/.gitignore
git config --global core.editor nvim

exit 0
