#!/bin/bash
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
    brew install neovim
fi
