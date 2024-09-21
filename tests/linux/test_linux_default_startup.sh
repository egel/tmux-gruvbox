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

  echo "Current DIR: $CURRENT_DIR"

  # link current repo to plugin list
  ln -sf ~/.tmux/plugins/tmux-gruvbox/ "$CURRENT_DIR/../"

  helper_install_tpm_plugins

  # start new detached session
  tmux new -d

  # get status of something from theme
  _status_left_current=$(tmux show-option -gqv status-left)
  if [[ "$STATUS_LEFT_DEFAULT" != "$_status_left_current" ]]; then
    helper_print_fail "status-left did not match"
  else
    helper_print_success "status-left match"
  fi

  helper_teardown
}

main "$@"
