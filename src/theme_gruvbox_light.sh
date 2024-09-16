#!/bin/bash

# Themes may use different colors in sets therefore we setup dark and light
# separately.
#
# shellcheck disable=SC2154
theme_set_light() {
  local _left_status_a _right_status_x _right_status_y _right_status_z _statusbar_alpha
  _left_status_a=$1
  _right_status_x=$2
  _right_status_y=$3
  _right_status_z=$4
  _statusbar_alpha=$5

  tmux_append_seto "status" "on"

  # default statusbar bg color
  local _statusbar_bg="${col_bg1}"
  if [[ "$_statusbar_alpha" == "true" ]]; then _statusbar_bg="default"; fi
  tmux_append_seto "status-style" "bg=${_statusbar_bg},fg=${col_fg1}"

  # default window title colors
  local _window_title_bg=${col_yellow2}
  if [[ "$_statusbar_alpha" == "true" ]]; then _window_title_bg="default"; fi
  tmux_append_setwo "window-status-style" "bg=${_window_title_bg},fg=${col_bg1}"

  # default window with an activity alert
  tmux_append_setwo "window-status-activity-style" "bg=${col_bg1},fg=${col_fg3}"

  # active window title colors
  local _active_window_title_bg=${col_yellow2}
  if [[ "$_statusbar_alpha" == "true" ]]; then _active_window_title_bg="default"; fi
  tmux_append_setwo "window-status-current-style" "bg=${_active_window_title_bg},fg=${col_bg1}" # TODO cosider removing red!

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

  tmux_append_seto "status-left" "#[bg=${col_bg3},fg=${col_fg3}] ${_left_status_a} #[bg=${col_bg1},fg=${col_bg3},nobold,noitalics,nounderscore]"

  # right status
  local _status_right_bg=${col_bg1}
  if [[ "$_statusbar_alpha" == "true" ]]; then _status_right_bg="default"; fi
  tmux_append_seto "status-right" "#[bg=${_status_right_bg},fg=${col_bg2},nobold,nounderscore,noitalics]#[bg=${col_bg2},fg=${col_fg4}] ${_right_status_x}  ${_right_status_y} #[bg=${col_bg2},fg=${col_fg3},nobold,noitalics,nounderscore]#[bg=${col_fg3},fg=${col_bg1}] ${_right_status_z}"

  # current window
  local _current_window_status_format_bg=${col_bg1}
  if [[ "$_statusbar_alpha" == "true" ]]; then _current_window_status_format_bg="default"; fi
  tmux_append_setwo "window-status-current-format" "#[bg=${col_yellow2},fg=${col_bg1},nobold,noitalics,nounderscore]#[bg=${col_yellow2},fg=${col_bg2}] #I #[bg=${col_yellow2},fg=${col_bg2},bold] #W#{?window_zoomed_flag,*Z,} #{?window_end_flag,#[bg=${_current_window_status_format_bg}],#[bg=${col_bg1}]}#[fg=${col_yellow2},nobold,noitalics,nounderscore]"

  # default window
  local _default_window_status_format_bg=${col_bg1}
  if [[ "$_statusbar_alpha" == "true" ]]; then _default_window_status_format_bg="default"; fi
  tmux_append_setwo "window-status-format" "#[bg=${col_bg2},fg=${col_bg1},noitalics]#[bg=${col_bg2},fg=${col_fg1}] #I #[bg=${col_bg2},fg=${col_fg1}] #W #{?window_end_flag,#[bg=${_default_window_status_format_bg}],#[bg=${col_bg1}]}#[fg=${col_bg2},noitalics]"
}
