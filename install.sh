#!/bin/bash

set -eu

INFO() {
	/bin/echo -e "\e[104m\e[97m[INFO]\e[49m\e[39m $@"
}

WARNING() {
	/bin/echo >&2 -e "\e[101m\e[97m[WARNING]\e[49m\e[39m $@"
}

ERROR() {
	/bin/echo >&2 -e "\e[101m\e[97m[ERROR]\e[49m\e[39m $@"
}

create_symbolic_link() {
  local src_path dst_path
  src_path=$1
  dst_path=$2

  if [ -L ${dst_path} ]; then
    INFO "Skip to create symbolic link '${dst_path}' because it is already created."
    return
  fi

  if [ -e ${dst_path} ]; then
    INFO "Rename current '${dst_path}' to '${dst_path}.back'."
    (
      set -x
      mv ${dst_path}{,.back}
    ) || :
  fi

  INFO "Create symbolic link."
  (
    set -x
    ln -s ${src_path} ${dst_path}
  ) || :
}

install_go_tools() {
  INFO "## Install Go tools"

  if ! type go > /dev/null 2>&1; then
    INFO "Skip installation because 'go' command is not found."
    return
  fi

  (
    set -x
    go install -v github.com/go-delve/delve/cmd/dlv@latest
    go install -v github.com/110y/goreturn@latest
  ) || :
}

setup_bash() {
  INFO "## Setup Bash"
  create_symbolic_link ${SCRIPT_DIR}/.bashrc ${HOME}/.bashrc
}

setup_vim() {
  INFO "## Setup Vim"
  create_symbolic_link ${SCRIPT_DIR}/.vimrc ${HOME}/.vimrc
  create_symbolic_link ${SCRIPT_DIR}/.vim ${HOME}/.vim

  if ! type vim > /dev/null 2>&1; then 
    INFO "Skip install vim plugin because 'vim' command is not found."
    return
  fi

  INFO "Install plugins."
  (
    set -x
    vim +PlugInstall +qall
  ) || :
}

setup_git() {
  INFO "## Setup Git"
  create_symbolic_link ${SCRIPT_DIR}/gitconfig ${HOME}/.gitconfig
  create_symbolic_link ${SCRIPT_DIR}/.tigrc ${HOME}/.tigrc
}

SCRIPT_DIR=$(dirname $(readlink -f $0))
cd ${SCRIPT_DIR}

setup_bash
setup_vim
setup_git
install_go_tools
