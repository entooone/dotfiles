if [[ -e /etc/bashrc ]]; then
  source /etc/bashrc
fi

export DOTFILES=${HOME}/dotfiles
export HISTFILE=${HOME}/.bash_history

# profile.d
#─────────────────────────────
for f in ${DOTFILES}/profile.d/*.sh; do
  source $f
done

# shopt
#─────────────────────────────
shopt -s autocd
shopt -s histappend

# key binding
#─────────────────────────────
stty stop undef # unbind C-s

# cd
#─────────────────────────────
if type go-cd > /dev/null 2>&1; then
  source <(go-cd init)
fi

# completion
#─────────────────────────────
if type wezterm > /dev/null 2>&1; then
  source <(wezterm shell-completion --shell bash)
fi
if [[ -e "${HOME}/.rye/env" ]]; then
  source "${HOME}/.rye/env"
fi

# local bashrc
#─────────────────────────────
if [[ -n "${MSYSTEM}" ]]; then
  source ${DOTFILES}/.bash/bashrc_msys
else
  source ${DOTFILES}/.bash/bashrc_linux
fi
export LOCAL_BASHRC="${DOTFILES}/.bash/bashrc.local"
if [[ -e "${LOCAL_BASHRC}" ]]; then
  source ${LOCAL_BASHRC}
fi

# load message
#─────────────────────────────
echo '~/.bashrc loaded' >&2
