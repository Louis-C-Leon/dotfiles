export EDITOR='nvim'
SAVEHIST=1000
HISTFILE=$HOME/.zsh_history

alias ls="ls -G"
alias g="git"
alias gs="git status"
alias gb="git branch"
alias gl="git log"
alias gp="git pull"
alias gP="git push"
alias gc="git commit -m"

bindkey -v

function open_nvim() { BUFFER="nvim"; zle accept-line; }
function nvm_use() { BUFFER="nvm use"; zle accept-line; }

# TODO: find a better way of doing this. Idk how the awk command works; seems weird to use awk and sed
function fzy_history() {
    echo ""
    BUFFER=$(history 0 | tail -r | sed "s/\( \)\{1,\}\([0-9]\)\{1,\}\( \)\{1,\}//" | awk '!_[$0]++' | fzy)
    zle accept-line
}

function fzy_cd() { 
    FOUND_DIR=$(fd --type d | fzy)
    DIRNAME_LEN=$(echo -n $FOUND_DIR | wc -m)
    if [[ DIRNAME_LEN -gt 0 ]]
    then
        BUFFER="cd ${FOUND_DIR}"
        zle accept-line
    else
        zle reset-prompt
    fi
}

zle -N open_nvim
zle -N nvm_use
zle -N fzy_history
zle -N fzy_cd

bindkey "^N" open_nvim
bindkey "^V" nvm_use
bindkey "^R" fzy_history
bindkey "^F" fzy_cd

export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PROMPT="%F{blue}%4~%f " 
precmd () {print -Pn "\e]0;%1d\a"}

if [[ -f $HOME/setup_env.zsh ]]
then
    source $HOME/setup_env.zsh
fi
