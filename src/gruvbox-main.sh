#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly CURRENT_DIR
readonly THEME_OPTION="@tmux-gruvbox"
readonly DEFAULT_THEME="dark"

# hold the array of all command to configure tmux theme
declate -a TMUX_CMDS

# load libraries
# shellcheck disable=1091
source "${CURRENT_DIR}/src/helper_methods.sh"
# shellcheck disable=1091
source "${CURRENT_DIR}/src/tmux_utils.sh"

readonly TMUX_GRUVBOX="@tmux-gruvbox"
readonly TMUX_GRUVBOX_STATUSBAR_ALPHA="@tmux-gruvbox-statusbar-alpha"
readonly TMUX_GRUVBOX_LEFT_STATUS_A="@tmux-gruvbox-left-status-a"
readonly TMUX_GRUVBOX_RIGHT_STAUTS_X="@tmux-gruvbox-right-status-x"
readonly TMUX_GRUVBOX_RIGHT_STAUTS_Y="@tmux-gruvbox-right-status-y"
readonly TMUX_GRUVBOX_RIGHT_STAUTS_Z="@tmux-gruvbox-right-status-z"

# define simple theme options (no color interpolation required)
DEFAULT_THEME="dark"
DEFAULT_STATUSBAR_ALPHA=false
# defaults for theme option (with color interpolation)
DEFAULT_LEFT_STATUS_A='#S'
DEFAULT_RIGHT_STATUS_X='%Y-%m-%d'
DEFAULT_RIGHT_STATUS_Y='%H:%M'
DEFAULT_RIGHT_STATUS_Z='#h'

main() {
  TMUX_CMDS=() # clear

  # load proper palette for the theme asap to avoid additional variable interpolation
  local _theme
  _theme=$(tmux_get_option "${TMUX_GRUVBOX}" "${DEFAULT_THEME}")
  _statusbar_alpha=$(tmux_get_option "${TMUX_GRUVBOX_STATUSBAR_ALPHA}" "${DEFAULT_STATUSBAR_ALPHA}")

  case "$_theme" in
  light | light256)
    # shellcheck disable=1091
    source "${CURRENT_DIR}/src/palette_gruvbox_light256.sh"
    # shellcheck disable=1091
    source "${CURRENT_DIR}/src/theme_gruvbox_light.sh"
    ;;
  dark | dark256 | *)
    # shellcheck disable=1091
    source "${CURRENT_DIR}/src/palette_gruvbox_dark256.sh"
    # shellcheck disable=1091
    source "${CURRENT_DIR}/src/theme_gruvbox_dark.sh"
    ;;
  esac

  local _status_left _status_right _window_status_current_format _window_status_format
  _status_left_a=$(tmux_get_option "$TMUX_GRUVBOX_LEFT_STATUS_A" "$DEFAULT_LEFT_STATUS_A")
  _status_right_x=$(tmux_get_option "$TMUX_GRUVBOX_RIGHT_STAUTS_X" "$DEFAULT_RIGHT_STATUS_X")
  _status_right_y=$(tmux_get_option "$TMUX_GRUVBOX_RIGHT_STAUTS_Y" "$DEFAULT_RIGHT_STATUS_Y")
  _status_right_z=$(tmux_get_option "$TMUX_GRUVBOX_RIGHT_STAUTS_Z" "$DEFAULT_RIGHT_STATUS_Z")

  theme_args=(
    "$_status_left_a"
    "$_status_right_x"
    "$_status_right_y"
    "$_status_right_z"
    "$_statusbar_alpha"
  )

  case $_theme in
  light | light256)
    theme_set_light "${theme_args[@]}"
    ;;
  dark | dark256 | *)
    theme_set_dark "${theme_args[@]}"
    ;;
  esac

  # execute commands with tmux as array of options
  tmux "${TMUX_CMDS[@]}"
}

main "$@"
