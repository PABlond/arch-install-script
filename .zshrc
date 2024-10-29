export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

ZSH_THEME="gallois"
ARCHFLAGS="-arch $(uname -m)"
setxkbmap fr
setxkbmap -option caps:escape
plugins=(git)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

alias :q='exit'
alias lla='ls -la'

# HYPHEN_INSENSITIVE="true"
# ENABLE_CORRECTION="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# export LANG=en_US.UTF-8

