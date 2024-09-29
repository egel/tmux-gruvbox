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
  local _msg="${1}"
  local _current_val="${2}"
  local _expected_val="${3}"
  printf "FAIL. %s\n" "${_msg}"
  printf "current value:\t%s\n" "$_current_val"
  printf "expected value:\t%s\n" "$_expected_val"
}

helper_print_success() {
  local _msg="${1}"
  printf "SUCCESS. %s\n" "${_msg}"
}

helper_print_fail_and_exit() {
  helper_print_fail "$1" "$2" "$3"
  exit 1
}

helper_print_success_and_exit() {
  helper_print_success "$1" "$2" "$3"
  exit 0
}

# install TMP plugins with command
helper_install_tpm_plugins() {
  bash -c "${HOME}/.tmux/plugins/tpm/scripts/install_plugins.sh install_plugins"
}

# return the value of tmux status-style
helper_tmux_get_statusstyle() {
  local _val
  _val=$(tmux show-option -gqv status-style)
  echo "$_val"
}

# return the value of tmux status-left
helper_tmux_get_statusleft() {
  local _val
  _val=$(tmux show-option -gqv status-left)
  echo "$_val"
}
