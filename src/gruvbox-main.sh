#!/bin/bash

SCRIPT_SRC="$(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")"
readonly SCRIPT_SRC
CURRENT_DIR=$(cd "${SCRIPT_SRC}" >/dev/null 2>&1 && pwd) readonly CURRENT_DIR
readonly CURRENT_DIR

# hold the array of all command to configure tmux theme
declate -a TMUX_CMDS

# load libraries
source "${CURRENT_DIR}/src/helper_methods.sh"
source "${CURRENT_DIR}/src/tmux_utils.sh"
source "${CURRENT_DIR}/src/theme_gruvbox_dark.sh"

readonly TMUX_GRUVBOX="@tmux-gruvbox"
readonly TMUX_GRUVBOX_THEME="@tmux-gruvbox-theme"
readonly TMUX_GRUVBOX_LEFT_STATUS="@tmux-gruvbox-left-status"
readonly TMUX_GRUVBOX_RIGHT_STAUTS="@tmux-gruvbox-right-status"
readonly TMUX_GRUVBOX_WINDOW_STATUS_CURRENT_FORMAT="@tmux-gruvbox-window-status-current-format"
readonly TMUX_GRUVBOX_WINDOW_STATUS_FORMAT="@tmux-gruvbox-window-status-format"

# define the reference names for further custom options
tmux_append_seto "${TMUX_GRUVBOX}"
tmux_append_seto "${TMUX_GRUVBOX_THEME}"
tmux_append_seto "${TMUX_GRUVBOX_LEFT_STATUS}"
tmux_append_seto "${TMUX_GRUVBOX_RIGHT_STAUTS}"
tmux_append_seto "${TMUX_GRUVBOX_WINDOW_STATUS_CURRENT_FORMAT}"
tmux_append_seto "${TMUX_GRUVBOX_WINDOW_STATUS_FORMAT}"

print_array TMUX_CMDS  # print options
tmux "${TMUX_CMDS[@]}" # execute options
TMUX_CMDS=()           # clean

main() {
  local _theme
  _theme=$(tmux_get_option "$TMUX_GRUVBOX" "$DEFAULT_THEME")

  # load proper palette for the theme soon to avoid additional variable interpolation
  case $_theme in
  light)
    source "${CURRENT_DIR}/src/palette_gruvbox_light.sh"
    ;;
  dark | *)
    source "${CURRENT_DIR}/src/palette_gruvbox_dark.sh"
    ;;
  esac

  # defaults for theme option
  DEFAULT_THEME="dark"
  DEFAULT_LEFT_STATUS="#[bg=${col_bg3},fg=${col_fg3}] #S #[bg=${col_bg1},fg=${col_bg3},nobold,noitalics,nounderscore]"
  DEFAULT_RIGHT_STATUS="#[bg=${col_bg1},fg=${col_bg2},nobold,nounderscore,noitalics]#[bg=${col_bg2},fg=${col_fg4}] %Y-%m-%d  %H:%M #[bg=${col_bg2},fg=${col_fg3},nobold,noitalics,nounderscore]#[bg=${col_fg3},fg=${col_bg1}] #h #{tmux_mode_indicator}"
  DEFAULT_WINDOW_STATUS_CURRENT_FORMAT="#[bg=${col_yellow2},fg=${col_bg1},nobold,noitalics,nounderscore]#[bg=${col_yellow2},fg=${col_bg2}] #I #[bg=${col_yellow2},fg=${col_bg2},bold] #W#{?window_zoomed_flag,*Z,} #[bg=${col_bg1},fg=${col_yellow2},nobold,noitalics,nounderscore]"
  DEFAULT_WINDOW_STATUS_FORMAT="#[bg=${col_bg2},fg=${col_bg1},noitalics]#[bg=${col_bg2},fg=${col_fg1}] #I #[bg=${col_bg2},fg=${col_fg1}] #W #[bg=${col_bg1},fg=${col_bg2},noitalics]"

  _status_left=$(tmux_get_option "$TMUX_GRUVBOX_LEFT_STATUS" "$DEFAULT_LEFT_STATUS")
  _status_right=$(tmux_get_option "$TMUX_GRUVBOX_RIGHT_STAUTS" "$DEFAULT_RIGHT_STATUS")
  _window_status_current_format=$(tmux_get_option "$TMUX_GRUVBOX_WINDOW_STATUS_CURRENT_FORMAT" "$DEFAULT_WINDOW_STATUS_CURRENT_FORMAT")
  _window_status_format=$(tmux_get_option "$TMUX_GRUVBOX_WINDOW_STATUS_FORMAT" "$DEFAULT_WINDOW_STATUS_FORMAT")

  theme_args=(
    "$_status_left"
    "$_status_right"
    "$_window_status_current_format"
    "$_window_status_format"
  )

  case $_theme in
  light)
    set_light_theme "${theme_args[@]}"
    ;;
  dark | *)
    set_dark_theme "${theme_args[@]}"
    ;;
  esac

  # execute commands with tmux as array of options
  tmux "${TMUX_CMDS[@]}"
}

main "$@"
