export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="egoista-sweet"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

export EDITOR="nvim"

alias update="sudo ~/.scripts/update.sh"
alias pac="pacaur"
alias dev=". ~/.scripts/dev.sh"
alias zshrc="$EDITOR ~/.zshrc && . ~/.zshrc"
alias env=". ./env/bin/activate"
alias py=". ~/.scripts/py.sh"
alias ml=". ~/.scripts/ml.sh"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/me/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
