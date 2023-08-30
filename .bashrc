if [ -e /etc/bashrc ]; then
    source /etc/bashrc
fi

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


# completion
#─────────────────────────────
if ! declare -f __git_complete &> /dev/null; then
    BASH_COMPLETION_DIR=$(pkg-config --variable=completionsdir bash-completion 2>/dev/null) \
    || BASH_COMPLETION_DIR='/usr/share/bash-completion/completions/'
    source $BASH_COMPLETION_DIR/git
fi
__git_complete g __git_main


# Prompt
#─────────────────────────────
__git_branch_name() {
  if type git > /dev/null 2>&1 && git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    GIT_BRANCH_NAME="($(git rev-parse --abbrev-ref HEAD 2>/dev/null)) "
  else
    GIT_BRANCH_NAME=""
  fi
  printf "${GIT_BRANCH_NAME}"
}
__ps1_hostname() {
  if [ -n "${WSL_DISTRO_NAME}" ]; then
    printf "[WSL]${WSL_DISTRO_NAME}"
  else
    printf "$(hostname)"
  fi
}
export PS1="\n\[\033[35m\]\t \[\033[32m\]\u@\`__ps1_hostname\` \[\033[33m\]\`__git_branch_name\`\w \[\033[34m\]\[\033[0m\]\n$ "


# Exports
#─────────────────────────────
export HISTFILE=$HOME/.bash_history


# cd
#─────────────────────────────
if type go-cd > /dev/null 2>&1; then
  source <(go-cd init)
fi

# key binding
#─────────────────────────────
stty stop undef # unbind C-s

# completion
#─────────────────────────────
if type wezterm > /dev/null 2>&1; then
  source <(wezterm shell-completion --shell bash)
fi
if type aqua > /dev/null 2>&1; then
  source <(aqua completion bash)
fi
if [ -e "${HOME}/.rye/env" ]; then
  source "${HOME}/.rye/env"
fi

# load message
#─────────────────────────────
echo '~/.bashrc loaded' >&2
