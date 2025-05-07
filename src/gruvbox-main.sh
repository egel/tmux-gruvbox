#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly CURRENT_DIR

# hold the array of all command to configure tmux theme
declare -a TMUX_CMDS

# load libraries
# shellcheck disable=1091
source "${CURRENT_DIR}/helper_methods.sh"
# shellcheck disable=1091
source "${CURRENT_DIR}/tmux_utils.sh"

readonly TMUX_GRUVBOX="@tmux-gruvbox"
readonly TMUX_GRUVBOX_STATUSBAR_ALPHA="@tmux-gruvbox-statusbar-alpha"
readonly TMUX_GRUVBOX_LEFT_STATUS_A="@tmux-gruvbox-left-status-a"
readonly TMUX_GRUVBOX_RIGHT_STAUTS_X="@tmux-gruvbox-right-status-x"
readonly TMUX_GRUVBOX_RIGHT_STAUTS_Y="@tmux-gruvbox-right-status-y"
readonly TMUX_GRUVBOX_RIGHT_STAUTS_Z="@tmux-gruvbox-right-status-z"

# define simple theme options (no color interpolation required)
readonly DEFAULT_THEME="dark256"
readonly DEFAULT_STATUSBAR_ALPHA='false'
# defaults for theme option (with color interpolation)
readonly DEFAULT_LEFT_STATUS_A='#S'
readonly DEFAULT_RIGHT_STATUS_X='%Y-%m-%d'
readonly DEFAULT_RIGHT_STATUS_Y='%H:%M'
readonly DEFAULT_RIGHT_STATUS_Z='#h'

main() {
  TMUX_CMDS=() # clear

  # load proper palette for the theme asap to avoid additional variable interpolation
  local _theme
  _theme=$(tmux_get_option "${TMUX_GRUVBOX}" "${DEFAULT_THEME}")
  _statusbar_alpha=$(tmux_get_option "${TMUX_GRUVBOX_STATUSBAR_ALPHA}" "${DEFAULT_STATUSBAR_ALPHA}")

  case "$_theme" in
  light)
    # shellcheck disable=1091
    source "${CURRENT_DIR}/palette_gruvbox_light.sh"
    # shellcheck disable=1091
    source "${CURRENT_DIR}/theme_gruvbox_light.sh"
    ;;
  light256)
    # shellcheck disable=1091
    source "${CURRENT_DIR}/palette_gruvbox_light256.sh"
    # shellcheck disable=1091
    source "${CURRENT_DIR}/theme_gruvbox_light256.sh"
    ;;
  dark)
    # shellcheck disable=1091
    source "${CURRENT_DIR}/palette_gruvbox_dark.sh"
    # shellcheck disable=1091
    source "${CURRENT_DIR}/theme_gruvbox_dark.sh"
    ;;
  dark256 | *)
    # shellcheck disable=1091
    source "${CURRENT_DIR}/palette_gruvbox_dark256.sh"
    # shellcheck disable=1091
    source "${CURRENT_DIR}/theme_gruvbox_dark.sh"
    ;;
  esac

  local _status_left _status_right _window_status_current_format _window_status_format
  _status_left_a=$(tmux_get_option "$TMUX_GRUVBOX_LEFT_STATUS_A" "$DEFAULT_LEFT_STATUS_A")
  _status_right_x=$(tmux_get_option "$TMUX_GRUVBOX_RIGHT_STAUTS_X" "$DEFAULT_RIGHT_STATUS_X")
  _status_right_y=$(tmux_get_option "$TMUX_GRUVBOX_RIGHT_STAUTS_Y" "$DEFAULT_RIGHT_STATUS_Y")
  _status_right_z=$(tmux_get_option "$TMUX_GRUVBOX_RIGHT_STAUTS_Z" "$DEFAULT_RIGHT_STATUS_Z")

  local _theme_args
  _theme_args=(
    "$_status_left_a"
    "$_status_right_x"
    "$_status_right_y"
    "$_status_right_z"
    "$_statusbar_alpha"
  )

  case $_theme in
  light256)
    # light256 have slightly different colors placement then regular light 16-bit
    theme_set_light256 "${_theme_args[@]}"
    ;;
  light)
    theme_set_light "${_theme_args[@]}"
    ;;
  dark | dark256 | *)
    theme_set_dark "${_theme_args[@]}"
    ;;
  esac

  # execute commands with tmux as array of options
  tmux "${TMUX_CMDS[@]}"
}

main "$@"
