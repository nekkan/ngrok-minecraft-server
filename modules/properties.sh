#!/bin/bash

function read_properties() {
  # Search for the file and the array for parsing properties.
  if [ -z "$1" ]; then
    echo "ERROR: Could not find the file location for parsing properties."
    exit 1
  fi
  if [ ! -e "$1" ]; then
    echo "ERROR: The given file '$1' was not found; the properties could not be parsed."
    exit 1
  fi

  local file_location=$1
  local -n array=$2

  if [ ${#array[@]} -eq 0 ]; then
    echo "ERROR: Could not find the array for parsing properties."
    exit 1
  fi

  while read line; do
    if echo "$line" | grep -F = &>/dev/null; then
      index=$(echo "$line" | cut -d '=' -f 1)
      array[$index]=$(echo "$line" | cut -d '=' -f 2-)
    fi
  done < "$file_location"
}
