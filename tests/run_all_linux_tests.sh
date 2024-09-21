#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

main() {
  set -e # exit on error
  _files=$(find "$CURRENT_DIR" -name "test_linux_*" -type f)
  for test in $_files; do
    bash -c "$test"
  done
}

main "$@"
