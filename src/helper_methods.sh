#!/bin/bash

# simply print passed array
#
# example
#
#   myarray=()
#   print_array myarray
#
print_array() {
  local -n arr # -n available over bash 4.3
  arr=$1

  echo ""
  echo "begin >>>"
  printf "%s\n" "${arr[@]}"
  echo "<<< end"
  echo ""
}
