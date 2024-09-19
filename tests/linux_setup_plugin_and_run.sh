#!/bin/bash

# this test is meant to run on linux
#
# test target is:
# - ubuntu 20.04 LTS
# - bash

# default value of status-left section from gruvbox theme
readonly STATUS_LEFT_DEFAULT="#[bg=colour241,fg=colour248] #S #[bg=colour237,fg=colour241,nobold,noitalics,nounderscore]"

main() {
  if [[ "$(uname)" != "Linux" ]]; then
    echo "NOT LINUX. Failed & exit."
    exit 1
  fi

  sudo apt update -y
  sudo apt install -y tmux git

  mkdir -p ~/.tmux/plugins/
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  cat <<EOF >~/.tmux.conf
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Other plugins
set -g @plugin 'egel/tmux-gruvbox'
set -g @tmux-gruvbox 'dark'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
EOF

  cat ~/.tmux.conf

  # manually install plugins
  bash -c "${HOME}/.tmux/plugins/tpm/scripts/install_plugins.sh install_plugins"

  # start new detached session
  tmux new -d

  # get status of something from theme
  _status_left_current=$(tmux show-option -gqv status-left)
  if [[ "$STATUS_LEFT_DEFAULT" != "$_status_left_current" ]]; then
    echo "$STATUS_LEFT_DEFAULT"
    echo "$_status_left_current"
    echo "FAILED"
    exit 1
  fi

  echo "SUCCESS"
  exit 0
}

main "$@"
