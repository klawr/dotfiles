  export ZSH=/c/Users/me/.oh-my-zsh

ZSH_THEME="egoista"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

export EDITOR="vim"

alias pac="pacman"
alias zshrc="$EDITOR ~/.zshrc && . ~/.zshrc"

alias yarn="winpty -- yarn.cmd"
alias electron="winpty -- electron.cmd"
alias node="winpty -- node.exe"
alias ng="winpty -- ng.cmd"
alias yo="winpty -- yo.cmd"
