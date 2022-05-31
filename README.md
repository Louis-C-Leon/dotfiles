This is my personal repo for dotfiles and configuration of my development environment. The main tools I use are the Kitty terminal emulator, Zshell, and the NeoVim code editor. To use this config, you should install Kitty, NeoVim, and Starship prompt, set your default shell to Zsh, and add a `~/.zshrc` file that sources `~/.config/zsh/louis-config.zsh`. Other important tools I have configured are NVM and FZF; these should also be installed.

## TODOS:
- Use gnu stow with this repo. Currently this directory must be located in your `~/.config` directory, but stow should allow me to clone this repo anywhere.
- Write a setup script that works on both MacOS and Fedora Linux. Should install all tooling and deps.
- Add debugger functionality to NeoVim.
- Add database functionality to NeoVim.
