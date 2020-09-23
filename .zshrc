# ==============================
# Autoloadings
# ==============================
autoload -Uz add-zsh-hook
autoload -Uz compinit && compinit -u
autoload -Uz url-quote-magic
autoload -Uz vcs_info

# ==============================
# General settings
# ==============================
setopt auto_cd
setopt auto_list
setopt auto_menu
setopt auto_pushd
setopt extended_history
setopt hist_reduce_blanks
setopt hist_verify
setopt ignore_eof
setopt inc_append_history
setopt interactive_comments
setopt no_beep
setopt no_hist_beep
setopt no_list_beep
setopt magic_equal_subst
setopt notify
setopt print_eight_bit
setopt print_exit_value
setopt prompt_subst
setopt pushd_ignore_dups
setopt rm_star_wait
setopt share_history
setopt transient_rprompt
setopt nomultios

# ==============================
# Prompt
# ==============================
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b'
setopt PROMPT_SUBST
export PROMPT=$'\n%F{yellow}%*%F{red} %n@%m%F{green} %~ %F{blue}${vcs_info_msg_0_}\n%F{white}%(!.#.$)%F{white} '

# ==============================
# Exports
# ==============================
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

# ==============================
# Completion
# ==============================
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' verbose yes
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:options' description 'yes'

# ==============================
# Key bindings
# ==============================
bindkey -e
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward
bindkey '^]'   vi-find-next-char
bindkey '^[^]' vi-find-prev-char

# ==============================
# Aliases
# ==============================
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

# ==============================
# Functions
# ==============================
scd() {
    dir=$(find ${1:-\.} -type d | fzy)
    if [ $? -eq 0 ]; then
        cd $dir
        ls
    fi
}

# ==============================
# Linux Brew
# ==============================
if [ -e "$HOME/.linuxbrew/bin/brew" ]; then
    eval $($HOME/.linuxbrew/bin/brew shellenv)
fi

# ==============================
# man 
# ==============================
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

# =============================
# golang
# =============================
if type "go" > /dev/null 2>&1; then
    export PATH=$PATH:$(go env GOPATH)/bin
fi

# =============================
# java
# =============================
export JAVA_HOME=/usr/lib/jvm/default
export JDK_HOME=/usr/lib/jvm/default
export PATH=$PATH:$JAVA_HOME/bin
export JUNIT_HOME=/usr/share/java
export CLASSPATH=$JUNIT_HOME/junit.jar:$CLASSPATH

# =============================
# Rootless Docker
# =============================
#export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock


# ==============================
# local zshrc
# ==============================
LOCAL_ZSHRC="$HOME/.zsh/zshrc.local"
if [ -e $LOCAL_ZSHRC ]; then
    source $LOCAL_ZSHRC
fi

# ==============================
# Load Message
# ==============================
echo "~/.zshrc loaded"

