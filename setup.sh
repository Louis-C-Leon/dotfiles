#!/bin/bash

echo 'Setting up my dev environment for Mac or Fedora'
source /etc/os-release
if [[ $OSTYPE == 'darwin'* ]]; then
    which -s brew
    if [[ $? != 0 ]] ; then
        echo 'Installing Homebrew'
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo 'Updating Homebrew'
        brew update
    fi
    echo 'Updating packages'
    brew upgrade
    echo 'Installing packages'
    brew install neovim kitty fd
elif [[ $PRETTY_NAME == 'Fedora'* ]]; then
    echo 'Updating packages'
    sudo dnf upgrade --refresh
    echo 'Installing packages'
    sudo dnf install neovim kitty fd-find git
else
    echo 'Did not identify OS as MacOS or Fedora. Exiting'
    exit 1
fi

echo 'Installing starship command prompt'
curl -sS https://starship.rs/install.sh | sh

echo 'Installing fzf with keybindings'
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install

echo 'Installing latest nvm version'
export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
)

# Link dotfiles
ln -sfbvT "$(pwd)/zshrc" $HOME/.zshrc
ln -sfbvT "$(pwd)/gitignore" $HOME/.gitignore
ln -sfbvT "$(pwd)/gitconfig" $HOME/.gitconfig
ln -sfbvt $HOME/.config "$(pwd)/nvim" "$(pwd)/kitty" "$(pwd)/starship.toml"

git config --global core.excludesfile $HOME/.gitignore

exit 0
