#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1091
source "${CURRENT_DIR}/../test_helpers.sh"

####
# Test: when the theme is not defined in config it should fallback to 'dark256'
#
main() {
  helper_tearup_linux

  # set config without theme defined
  cat <<EOF >~/.tmux.conf
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Other plugins
set -g @plugin 'egel/tmux-gruvbox'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
EOF

  cat ~/.tmux.conf

  # it's essential to link current repo to the plugins' directory
  ln -sfv "$CURRENT_DIR/../../../tmux-gruvbox" "${HOME}/.tmux/plugins/tmux-gruvbox"

  helper_install_tpm_plugins

  # start new detached session
  tmux new -d

  # check if left side match
  _status_left_expected="#[bg=colour241,fg=colour248] #S #[bg=colour237,fg=colour241,nobold,noitalics,nounderscore]"
  _status_left_current=$(helper_tmux_get_statusleft)
  if [[ "$_status_left_current" != "$_status_left_expected" ]]; then
    helper_print_fail "status-left did not match" "$_status_left_current" "$_status_left_expected"
    helper_teardown
    exit 1
  fi
  # check if status is not transparent
  _status_style_expected="bg=colour237,fg=colour223"
  _status_style_current=$(helper_tmux_get_statusstyle)
  if [[ "$_status_style_current" != "$_status_style_expected" ]]; then
    helper_print_fail "status-style did not match" "$_status_style_current" "$_status_style_expected"
    helper_teardown
    exit 1
  fi

  helper_print_success "status-left match"
  helper_teardown
  exit 0
}

main "$@"
