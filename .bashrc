
# dotfiles
#─────────────────────────────
export DOTFILES=${HOME}/dotfiles


# profile.d
#─────────────────────────────
for f in ${DOTFILES}/profile.d/*.sh; do
    source $f
done


# local bashrc
#─────────────────────────────
LOCAL_BASHRC="${DOTFILES}/.bash/bashrc.local"
if [ -e $LOCAL_BASHRC ]; then
    source $LOCAL_BASHRC
fi


# shopt
#─────────────────────────────
shopt -s autocd
shopt -s histappend


# Prompt
#─────────────────────────────
__prompt_git() {
if type __git_ps1 &> /dev/null; then
    __git_ps1 %s
fi
}
export PS1="\n\[\033[35m\]\t \[\033[32m\]\u@\h \[\033[33m\]\w \[\033[34m\]\$(__prompt_git)\[\033[0m\]\n$ "


# Exports
#─────────────────────────────
export HISTFILE=$HOME/.bash_history


# completion
#─────────────────────────────
if ! declare -f __git_complete &> /dev/null; then
    BASH_COMPLETION_DIR=$(pkg-config --variable=completionsdir bash-completion 2>/dev/null) \
    || BASH_COMPLETION_DIR='/usr/share/bash-completion/completions/'
    source $BASH_COMPLETION_DIR/git
fi
__git_complete g __git_main


# cd
#─────────────────────────────
eval "$(go-cd init)"


# key binding
#─────────────────────────────
stty stop undef # unbind C-s
bind -x '"\200": TEMP_LINE=$READLINE_LINE; TEMP_POINT=$READLINE_POINT'
bind -x '"\201": READLINE_LINE=$TEMP_LINE; READLINE_POINT=$TEMP_POINT; unset TEMP_POINT; unset TEMP_LINE'
bind -x '"\206":"cd -f"'
bind '"\C-s": "\200\C-a\C-k\206\C-m\201"'


# load message
#─────────────────────────────
echo '~/.bashrc loaded'
