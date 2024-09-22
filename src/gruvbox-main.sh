#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
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
  local _theme _path
  _theme=$(get_theme "$THEME_OPTION" "$DEFAULT_THEME")
  case "$_theme" in
  light-transparent)
    _theme="light-transparent"
    ;;
  dark-transparent)
    _theme="dark-transparent"
    ;;
  light | light256)
    _theme="light"
    ;;
  dark | dark256 | *)
    _theme="dark"
    ;;
  esac

  tmux source-file "${CURRENT_DIR}/tmux-gruvbox-${_theme}.conf"
}

main "$@"
