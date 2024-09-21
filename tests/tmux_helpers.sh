#!/bin/bash

helper_teardown_tmux() {
  rm -rf ~/.tmux.conf
  rm -rf ~/.tmux/
  tmux kill-server >/dev/null 2>&1
}

helper_tearup_linux_tmux() {
  if [[ "$(uname)" != "Linux" ]]; then
    echo "NOT LINUX. Failed & exit."
    exit 1
  fi

  # install software
  sudo apt update -y
  sudo apt install -y tmux git

  # download TPM
  mkdir -p ~/.tmux/plugins/
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

helper_print_fail_and_exit() {
  local _msg="${1:-}"
  printf "FAIL. %s\n" "${_msg}"
  exit 1
}

helper_print_success_and_exit() {
  local _msg="${1:-}"
  printf "SUCCESS. %s\n" "${_msg}"
  exit 0
}

# install TMP plugins with command
helper_install_tpm_plugins() {
  bash -c "${HOME}/.tmux/plugins/tpm/scripts/install_plugins.sh install_plugins"
}
