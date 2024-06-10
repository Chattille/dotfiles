# Basic
alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias ls='command ls --color=always'
alias la='ls -A'
alias ll='ls -Alh'
alias tree='command tree -C'
alias c='clear -x'
alias du='command du -bsh'
alias oalias="nvim $HOME/.zim/aliases.zsh"

# Utilities
alias nv='nvim'
alias nvcf="nvim $HOME/.config/nvim/init.lua"
alias rezsh='exec zsh'
alias zcf="nvim $HOME/.zshrc"

# Git
alias g='git'
alias ga='git add'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log'
alias gm='git commit'
alias gmm='git commit -m'
alias gs='git status'

# Functions
ldu() {
    local tgt=${1:-$PWD}
    command du -bahd 1 $tgt | sort -h
}

dk() {
    local cmd=$1

    case $cmd {
        cd) shift; command docker compose down "$@";;
        cu) shift; command docker compose up --detach "$@";;
        ia) shift; command docker images --all "$@";;
        is) shift; command docker images "$@";;
        ns) shift; command docker network ls "$@";;
        pa) shift; command docker container ls --all "$@";;
        vs) shift; command docker volume ls "$@";;
        *) command docker "$@";;
    }
}
