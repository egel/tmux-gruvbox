#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1091
source "${CURRENT_DIR}/../tmux_helpers.sh"

# default value of status-left section from gruvbox theme
readonly STATUS_LEFT_DEFAULT="#[bg=colour241,fg=colour248] #S #[bg=colour237,fg=colour241,nobold,noitalics,nounderscore]"

main() {
  helper_tearup_linux_tmux

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

  helper_install_tpm_plugins

  # start new detached session
  tmux new -d

  # get status of something from theme
  _status_left_current=$(tmux show-option -gqv status-left)
  if [[ "$STATUS_LEFT_DEFAULT" != "$_status_left_current" ]]; then
    helper_print_fail_and_exit "Status left did not match"
  fi

  helper_print_success_and_exit "Status left match"
}

main "$@"
