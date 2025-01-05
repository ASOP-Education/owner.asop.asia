#!/bin/bash

function generate_random_string() {
  local length="${1:-500}" 
  local chars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  local random_string=""
  for (( i=0; i<$length; i++ )); do
    random_string+=${chars:$(tr -dc A-Za-z0-9 </dev/urandom | fold -w1 | head -n1):1}}
  done
  echo "$random_string"
}
random_alphanumeric=$(generate_random_string)
output="owner.asop.asia={$random_alphanumeric}"
echo "$output"
