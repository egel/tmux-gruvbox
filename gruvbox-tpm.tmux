#!/usr/bin/env bash

SCRIPT_SRC="$(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")"
readonly SCRIPT_SRC
CURRENT_DIR=$(cd "${SCRIPT_SRC}" >/dev/null 2>&1 && pwd)
readonly CURRENT_DIR
readonly THEME_OPTION="@tmux-gruvbox"
readonly DEFAULT_THEME="dark"

get_theme() {
  local option="$1"
  local default_value="$2"
  local option_value
  option_value=$(tmux show-option -gqv "$option")
  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

main() {
  local theme
  theme=$(get_theme "$THEME_OPTION" "$DEFAULT_THEME")
  tmux source-file "$CURRENT_DIR/tmux-gruvbox-${theme}.conf"
}

main "$@"

# vim: ai et ft=bash
