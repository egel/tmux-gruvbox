#!/usr/bin/env bash

main() {
  for test in $(compgen -A function | grep "^test_linux_"); do "$test"; done
}

main "$@"
