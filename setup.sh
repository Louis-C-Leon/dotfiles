#!/bin/bash
source /etc/os-release
if [[ $OSTYPE == 'darwin'* ]]; then
    echo 'Setting up for macOS'
    which -s brew
    if [[ $? != 0 ]] ; then
        echo 'Installing Homebrew'
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo 'Updating Homebrew'
        brew update
    fi
    brew install neovim kitty
elif [[ $PRETTY_NAME == 'Fedora'* ]]; then
    echo 'Setting up for Fedora Linux'
    sudo dnf install neovim kitty
else
    echo 'This script is only configured for MacOS and Fedora Linux'
    echo 'Looks like this is a different OS. Sorry!'
    exit 1
fi

ln -sfv "$(pwd)/.zshrc" $HOME
ln -sfv "$(pwd)/.gitconfig" $HOME
ln -sfv "$(pwd)/global_gitignore" $HOME .gitignore
ln -sfv "$(pwd)/.config/nvim" $HOME/.config
ln -sfv "$(pwd)/.config/kitty" $HOME/.config
ln -sfv "$(pwd)/.config/starship.toml" $HOME/.config

git config --global core.excludesfile ~/.gitignore

exit 0
