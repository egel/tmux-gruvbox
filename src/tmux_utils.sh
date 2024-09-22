#!/bin/bash

# get desired tmux option or use given default value
tmux_get_option() {
  local _option_name _default_value
  _option_name="$1"
  _default_value="$2"

  local _current_option_value
  _current_option_value=$(tmux show-option -gqv "$_option_name")
  if [[ -n "$_current_option_value" ]]; then
    echo "$_current_option_value"
  else
    echo "$_default_value"
  fi
}

# get desired window-option from tmux or default
tmux_get_window_option() {
  local _option_name _default_value
  _option_name="$1"
  _default_value="$2"

  local _current_option_value
  _current_option_value=$(tmux show-window-option -gqv "$_option_name")
  if [[ -n "$_current_option_value" ]]; then
    echo "$_current_option_value"
  else
    echo "$_default_value"
  fi
}

# append preconfigured tmux set-option to global array
tmux_append_seto() {
  local _option _value _result
  _option="$1"
  _value="$2"
  TMUX_CMDS+=("set-option" "-gq" "${_option}" "${_value}" ";")
}

# append preconfigured tmux set-window-option to global array
tmux_append_setwo() {
  local _option _value _result
  _option="$1"
  _value="$2"
  TMUX_CMDS+=("set-window-option" "-gq" "${_option}" "${_value}" ";")
}

# imediately execute tmux option
tmux_set_option_now() {
  local _option_name _value
  _option_name="$1"
  _value="$2"
  tmux set-option -gq "$_option_name" "$_value"
}

# imediately execute tmux option
tmux_set_window_option_now() {
  local _option_name _value
  _option_name="$1"
  _value="$2"
  tmux set-window-option -gq "$_option_name" "$_value"
}
