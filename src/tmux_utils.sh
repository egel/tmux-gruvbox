#!/bin/bash

# get desired option from tmux or default
tmux_get_option() {
  local _option _default_value
  _option="$1"
  _default_value="$2"

  local _option_value
  _option_value=$(tmux show-option -gqv "$_option")
  if [ -z "$_option_value" ]; then
    echo "$_default_value"
  else
    echo "$_option_value"
  fi
}

# append preconfigured tmux set-option to global array
tmux_append_seto() {
  local _option _value _result
  _option="$1"
  _value="$2"
  TMUX_CMDS+=("set-option" "-gq" "${_option}" "${_value}" ";")
  # _retult=("set-option -gq" "${_option}" "${_value}" ";")
  # echo "${_retult[*]}"
}

# append preconfigured tmux set-window-option to global array
tmux_append_setwo() {
  local _option _value _result
  _option="$1"
  _value="$2"
  TMUX_CMDS+=("set-window-option" "-gq" "${_option}" "${_value}" ";")
  # _retult=("set-window-option -gq" "${_option}" "${_value}" ";")
  # echo "${_retult[*]}"
}
