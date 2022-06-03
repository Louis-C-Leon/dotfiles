export EDITOR='nvim'
SAVEHIST=1000
HISTFILE=$HOME/.zsh_history

alias ls='ls -G'
alias v='nvm use'
alias g='git'
alias n='nvim'


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='
  --layout=reverse --height 50%
  --color=bg+:#0F191F,bg:#0F191F,spinner:#B279A7,hl:#90FF6B
  --color=fg:#C6D5CF,header:#C6D5CF,info:#DE6E7C,pointer:#90FF6B
  --color=marker:#90FF6B,fg+:#B279A7,prompt:#90FF6B,hl+:#90FF6B
'
export FZF_DEFAULT_COMMAND='fd -I -H -E ".git"'
export FZF_CTRL_T_COMMAND='fd -I -H -E ".git"'

export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init zsh)"

precmd () {print -Pn "\e]0;%1d\a"}
