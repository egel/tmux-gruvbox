#!/bin/bash

# themes may use different colors in sets therefore we setup dark and light separately
set_dark_theme() {
  local _left_status_value _right_status_value _window_status_current_format
  _left_status_value=$1
  _right_status_value=$2
  _window_status_current_format=$3
  _window_status_format=$4

  tmux_append_seto "status" "on"

  # default statusbar color
  tmux_append_seto "status-style" "bg=${col_bg1},fg=${col_fg1}"

  # default window title colors
  tmux_append_setwo "window-status-style" "bg=${col_yellow2},fg=${col_bg1}"

  # default window with an activity alert
  tmux_append_setwo "window-status-activity-style" "bg=${col_bg1},fg=${col_fg3}"

  # active window title colors
  tmux_append_setwo "window-status-current-style" "bg=default,fg=${col_bg1}" # TODO cosider removing red!

  # pane border
  tmux_append_seto "pane-active-border-style" "fg=${col_fg2}"
  tmux_append_seto "pane-border-style" "fg=${col_bg1}"

  # message infos
  tmux_append_seto "message-style" "bg=${col_bg2},fg=${col_fg1}"

  # writing commands inactive
  tmux_append_seto "message-command-style" "bg=${col_fg3},fg=${col_bg1}"

  # pane number display
  tmux_append_seto "display-panes-active-colour" "${col_fg2}"
  tmux_append_seto "display-panes-colour" "${col_bg1}"

  # clock
  tmux_append_setwo "clock-mode-colour" "${col_blue2}"

  # bell
  tmux_append_setwo "window-status-bell-style" "bg=${col_red2},fg=${col_bg}"

  ## Theme settings mixed with colors (unfortunately, but there is no cleaner way)
  tmux_append_seto "status-justify" "left"
  tmux_append_seto "status-left-style" none
  tmux_append_seto "status-left-length" "80"
  tmux_append_seto "status-right-style" none
  tmux_append_seto "status-right-length" "80"
  tmux_append_setwo "window-status-separator" ""

  tmux_append_seto "status-left" "${_left_status_value}"
  tmux_append_seto "status-right" "${_right_status_value}"

  tmux_append_setwo "window-status-current-format" "${_window_status_current_format}"
  tmux_append_setwo "window-status-format" "${_window_status_format}"
}
