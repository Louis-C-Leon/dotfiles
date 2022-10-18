export EDITOR='nvim'
SAVEHIST=2000
HISTFILE=$HOME/.zsh_history

alias ls='ls -G'
alias g='git'
alias gs='git status'
alias gb='git branch'
alias gl='git log'

export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PROMPT='%F{blue}%4~%f $ ' 
precmd () {print -Pn "\e]0;%1d\a"}
source $HOME/setup_env.zsh
