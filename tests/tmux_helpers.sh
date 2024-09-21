#!/bin/bash

helper_teardown() {
  echo "TEARDOWN"
  rm -rf ~/.tmux.conf
  rm -rf ~/.tmux/
  tmux kill-server >/dev/null 2>&1
}

helper_tearup_linux() {
  if [[ "$(uname)" != "Linux" ]]; then
    echo "NOT LINUX. Failed & exit."
    exit 1
  fi
  echo "TEARUP LINUX"

  # install software
  sudo apt update -y
  sudo apt install -y tmux git

  # download TPM
  mkdir -p ~/.tmux/plugins/
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

helper_print_fail() {
  local _msg="${1:-}"
  printf "FAIL. %s\n" "${_msg}"
}

helper_print_success() {
  local _msg="${1:-}"
  printf "SUCCESS. %s\n" "${_msg}"
}

helper_print_fail_and_exit() {
  helper_print_fail "$1"
  exit 1
}

helper_print_success_and_exit() {
  helper_print_success "$1"
  exit 0
}

# install TMP plugins with command
helper_install_tpm_plugins() {
  bash -c "${HOME}/.tmux/plugins/tpm/scripts/install_plugins.sh install_plugins"
}

helper_get_project_root_dir() {
  _current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  echo "${_current_dir}/../"
}