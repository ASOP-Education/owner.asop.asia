#!/bin/bash

function get_file_hash() {
  local file_path="$1"
  local hash_algorithm="sha256"

  if [[ ! -f "$file_path" ]]; then
    echo "Error: File '$file_path' does not exist." >&2
    return 1
  fi

  # Calculating the hash
  hash_value=$(openssl dgst -"$hash_algorithm" "$file_path" | awk '{print $2}')

  echo "$hash_value"
}
# Get the file path from the user
read -p "Enter the file path: " file_path
file_hash=$(get_file_hash "$file_path")
if [[ $? -eq 0 ]]; then
  echo "SHA256 hash of '$file_path': $file_hash"
fi
