
# dotfiles
#─────────────────────────────
export DOTFILES=${HOME}/dotfiles


# profile.d
#─────────────────────────────
for f in ${DOTFILES}/profile.d/*.sh; do
    source $f
done

# Autoloadings
#─────────────────────────────
autoload -Uz add-zsh-hook
autoload -Uz compinit && compinit -u
autoload -Uz url-quote-magic
autoload -Uz vcs_info


# General settings
#─────────────────────────────
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


# Prompt
#─────────────────────────────
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b'
setopt PROMPT_SUBST
export PROMPT=$'\n%F{yellow}%*%F{red} %n@%m%F{green} %~ %F{blue}${vcs_info_msg_0_}\n%F{white}%(!.#.$)%F{white} '


# Exports
#─────────────────────────────
export HISTFILE=$HOME/.zhistory


# Completion
#─────────────────────────────
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' verbose yes
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:options' description 'yes'


# Key bindings
#─────────────────────────────
bindkey -e
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward
bindkey '^]'   vi-find-next-char
bindkey '^[^]' vi-find-prev-char


# local zshrc
#─────────────────────────────
LOCAL_ZSHRC="$HOME/.zsh/zshrc.local"
if [ -e $LOCAL_ZSHRC ]; then
    source $LOCAL_ZSHRC
fi


# Load Message
#─────────────────────────────
echo "~/.zshrc loaded"
