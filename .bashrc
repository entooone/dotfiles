
# dotfiles
#─────────────────────────────
export DOTFILES=${HOME}/dotfiles


# profile.d
#─────────────────────────────
for f in ${DOTFILES}/profile.d/*.sh; do
    source $f
done


# shopt
#─────────────────────────────
shopt -s autocd
shopt -s histappend


# Prompt
#─────────────────────────────
export PS1='\n\[\033[35m\]\t \[\033[32m\]\u@\h \[\033[33m\]\w \[\033[34m\]`__git_ps1 "%s"`\[\033[0m\]\n$ '


# Exports
#─────────────────────────────
export HISTFILE=$HOME/.bash_history


# local bashrc
#─────────────────────────────
LOCAL_BASHRC="${DOTFILES}/.bash/bashrc.local"
if [ -e $LOCAL_BASHRC ]; then
    source $LOCAL_BASHRC
fi

# Load Message
#─────────────────────────────
echo '~/.bashrc loaded'
