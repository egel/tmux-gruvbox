#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

main() {
  set -e # exit on error
  declare -i _countFailures
  local _files
  _countFailures=0
  _files=$(find "$CURRENT_DIR/linux" -name "test_*" -type f)
  for test in $_files; do
    printf "\n"
    printf "\n=============================================="
    printf "\n %s" "$test"
    printf "\n=============================================="
    printf "\n"
    bash -c "$test"

    # run all and count failures
    retVal=$?
    if [ $retVal -eq 1 ]; then
      _countFailures+=1
    fi
  done

  # check if anything failed and fail
  if [ "$_countFailures" -gt 0 ]; then
    exit 1
  fi
}

main "$@"
