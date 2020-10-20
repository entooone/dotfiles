# Exports
#─────────────────────────────
export CLICOLOR=true
export LSCOLORS='exfxcxdxbxGxDxabagacad'
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/firefox
export HISTFILE=$HOME/.zhistory
export HISTSIZE=100000
export SAVEHIST=1000000
export SCREENDIR=$HOME/.screen
export TERM=xterm-256color
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/dotfiles/bin
export FZF_DEFAULT_COMMAND='find . | grep -v -E ".git"'
export FZF_DEFAULT_OPTS='--preview "if [ -d {} ]; then ls -1F --color {}/; else cat {}; fi"'
if type bat &> /dev/null; then
    export FZF_DEFAULT_OPTS='--preview "if [ -d {} ]; then ls -1F --color {}/; else bat --style=numbers --color=always --line-range :500 {}; fi"'
fi


# Aliases
#─────────────────────────────
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -FC --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias c='cd'
alias po='popd'
alias pu='pushd'
alias l='ls'
alias ll='ls -alF'
alias la='ls -A'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias less='less -NMR'
alias ip='ip -c'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias s="ssh"
alias d="docker"
alias dc="docker-compose"
if type "vim" > /dev/null 2>&1; then
    alias vi='vim'
fi


# man 
#─────────────────────────────
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}


# golang
#─────────────────────────────
if type "go" > /dev/null 2>&1; then
    export PATH=$PATH:$(go env GOPATH)/bin
fi


# Load Message
#─────────────────────────────
echo '~/.bashrc loaded'
